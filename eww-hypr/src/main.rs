use std::{
    io::{BufRead, BufReader},
    os::unix::net::UnixStream,
    path::Path,
};

use clap::Parser;
use serde::{Deserialize, Serialize};

#[derive(Debug, Parser)]
enum Cli {
    Workspaces { monitor_id: u32 },
    Clock { format: String },
}

fn main() -> std::io::Result<()> {
    let cli = Cli::parse();

    match cli {
        Cli::Workspaces { monitor_id } => watch_workspaces(monitor_id)?,
        Cli::Clock { format } => watch_clock(&format),
    }

    Ok(())
}

fn watch_workspaces(monitor_id: u32) -> std::io::Result<()> {
    get_workspaces(monitor_id);
    let hyprland_instance_signature = std::env::var("HYPRLAND_INSTANCE_SIGNATURE")
        .expect("env var HYPRLAND_INSTANCE_SIGNATURE not set");
    let hyprland_event_socket_path = Path::new("/tmp/hypr/")
        .join(hyprland_instance_signature)
        .join(".socket2.sock");
    let hyprland_event_socket = UnixStream::connect(hyprland_event_socket_path)?;
    let hyprland_event_socket = BufReader::new(hyprland_event_socket);

    for line in hyprland_event_socket.lines() {
        let line = line?;
        let Some((event, _data)) = line.split_once(">>") else {
            continue;
        };
        match event {
            "focusedmon" | "workspace" => {
                get_workspaces(monitor_id);
            }
            _ => {}
        }
    }
    Ok(())
}

fn get_workspaces(monitor_id: u32) {
    let workspaces_output = std::process::Command::new("hyprctl")
        .arg("workspaces")
        .arg("-j")
        .output()
        .unwrap()
        .stdout;

    let workspaces: Vec<Workspace> = serde_json::from_slice(&workspaces_output).unwrap();
    let mut workspaces: Vec<Workspace> = workspaces
        .into_iter()
        .filter(|w| w.monitor_id == monitor_id)
        .collect();

    workspaces.sort_unstable_by_key(|w| w.id);

    let monitors_output = std::process::Command::new("hyprctl")
        .arg("monitors")
        .arg("-j")
        .output()
        .unwrap()
        .stdout;
    let monitors: Vec<Monitor> = serde_json::from_slice(&monitors_output).unwrap();
    let monitor = monitors.into_iter().find(|m| m.id == monitor_id).unwrap();
    let active_workspace = workspaces
        .iter_mut()
        .find(|w| w.id == monitor.active_workspace.id)
        .unwrap();
    active_workspace.active = true;

    let json_workspaces = serde_json::ser::to_string(&workspaces).unwrap();
    println!("{json_workspaces}");
}

#[derive(Debug, Serialize, Deserialize)]
struct Workspace {
    id: u32,

    #[serde(rename = "monitorID")]
    monitor_id: u32,
    windows: u32,
    #[serde(rename = "hasfullscreen")]
    has_fullscreen: bool,

    #[serde(skip_deserializing)]
    active: bool,
}

#[derive(Debug, Serialize, Deserialize)]
struct Monitor {
    id: u32,
    #[serde(rename = "activeWorkspace")]
    active_workspace: MonitorActiveWorkspace,
}

#[derive(Debug, Serialize, Deserialize)]
struct MonitorActiveWorkspace {
    id: u32,
}

fn watch_clock(format: &str) {
    use chrono::prelude::*;

    loop {
        let now = Local::now();
        let now_str = now.format(format);
        println!("{now_str}");

        let seconds = now.time().second();
        // Add an extra second to be safe
        std::thread::sleep(std::time::Duration::from_secs(60 - seconds as u64 + 1));
    }
}
