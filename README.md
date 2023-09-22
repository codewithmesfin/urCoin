# urCoin Flutter Decentralized App

## Introduction
Welcome to the README for our UrCoin Flutter app! This document provides essential information to help you understand, set up, and contribute to our UrCoin application. Whether you are a developer, tester, or user, this guide will assist you in getting started with our app.

## Table of Contents
- [About UrCoin](#about-urcoin)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)


## About UrCoin
UrCoin is a small Flutter Wallet dApp that allows users to transfer cryptocurrencies easily. The app is developed based on the Ethereum Virtual Machine (EVM) and supports the following networks:
- Ethereum Mainnet
- Goerli Test Net
- Sepolia Test Net

With UrCoin, you can securely manage your cryptocurrencies and make quick and efficient transactions on multiple Ethereum-based networks.

## Getting Started

### Prerequisites
Before you start, make sure you have the following prerequisites installed on your development machine:

- [Flutter](https://flutter.dev/docs/get-started/install): Make sure you have Flutter installed. You can check this by running `flutter --version` in your terminal.

### Installation
1. Clone the repository:
   ```git clone https://github.com/sciemesfin/urCoin.git```
2. Change your working directory to the app's directory:
   ```cd urCoin```
3. Get the dependencies:
   ```flutter pub get```
4. Create a .env file in the root directory of the app with the following content:
```
   ETHER_SCAN_API_KEY=Your_Ether_Scan_API_KEY
   SEPOLIA_API_KEY=Your_Alchemy_or_other_Provider_API_KEY
```

5. Run the app:
```flutter run```

## Usage
This section provides information on how to use the app, its features, and any necessary configurations.

**User Guide**: Provide a brief user guide here or link to a separate document or webpage with detailed user instructions.
**Configuration**: If your app requires specific configurations (e.g., API keys, environment variables), explain how to set them up, as mentioned in the Installation section.
**Troubleshooting**: Include common issues users might encounter and their solutions.

## Contributing
We welcome contributions to our UrCoin Flutter app! If you'd like to contribute, please follow these steps:

1. Fork the repository on GitHub.
2. Clone your forked repository to your local machine.
3. Create a new branch for your feature or bug fix.
4. Make your changes and test them thoroughly.
5. Commit your changes with clear and concise commit messages.
6. Push your changes to your forked repository.
7. Create a pull request to the original repository.