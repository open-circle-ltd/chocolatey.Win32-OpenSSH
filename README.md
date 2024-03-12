# Chocolatey Package: Win32-OpenSSH

## Description

Installs Win32-OpenSSH.

## Package Parameters

- `/server` to install only SSH Server
- `/client` to install only the SSH Client
- When no parameters are supplied, both client and server will be installed

## Installation

### choco

Installation without parameters.

```ps1
 choco install win32-openssh
```

Installation with parameters.

```ps1
 choco install win32-openssh --params="'/server'"
```

## Disclaimer

These Chocolatey Packages only contain installation routines. The software itself is downloaded from the official sources of the software developer. Open Circle AG has no affilation with the software developer.

## Author

- [Kevin Pestalozzi](https://github.com/kpestalozzi)
- [Open Circle AG](https://www.open-circle.ch)

## License

This project is under the MIT License. See the [LICENSE](LICENSE) file for the full license text.

## Copyright

(c) 2024, Open Circle AG
