# Hunt #004 — New Local Admin Account Creation

```
data.win.eventdata.eventID:4732 AND data.win.eventdata.targetGroupName:"Administrators"
```

Cross-reference results against the documented AD user baseline in
docs/phase-notes/phase3-vm-deployment.md - anything not on that list during
a hunt window is worth opening a case for.
