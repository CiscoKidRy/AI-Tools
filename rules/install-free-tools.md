# Install free preferred tools before falling back

When the best tool for a task is not installed and that software is free/open-source, **default to downloading and installing it** before trying a different tool.

1. Prefer the genuinely best tool for the job.
2. If it is missing and free, attempt install first (pip, npm, brew, cargo, apt, etc.).
3. Prefer user-scoped installs when possible to avoid unnecessary sudo.
4. Confirm only for privileged, global, or system-wide installs that expand machine blast radius.
5. Fall back only if install fails, the software is paid, install needs privileges/agreements the user has not granted, or the user forbade it.
6. After install, continue with the preferred tool and briefly note what was installed.
