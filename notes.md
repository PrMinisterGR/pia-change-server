# How to use the PIA Daemon

## Location

Default location is:

```text
 C:\Program Files\Private Internet Access
 ```

## Command

Default command is:

```text
piactl.exe
```

### Connect / Disconnect

```text
piactl.exe connect
```

```text
piactl.exe disconnect
```

### Get

#### Connection State

Can be:
```text
Disconnected, Connecting, Connected, Interrupted, Reconnecting, DisconnectingToReconnect, Disconnecting
```

```powershell
piactl.exe get connectionstate
```

#### Regions / Region / VPNIP

```powershell
piactl.exe get region
```

```powershell
piactl.exe get regions
```

```powershell
piactl.exe get vpnip
```