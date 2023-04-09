# R

This repository contains R-lang programs and scripts under the GPL v3 license.

## Table of Contents
- [Getting Started](#getting-started)
  * [Installing R-Lang](#installing-r-lang)
  * [Installing Repository](#installing)
- [Usage](#usage)
  * [Running Scripts](#running-scripts)
  * [Running Programs](#running-programs)
- [Contributing](#contributing)
- [License](#license)

## Getting Started

### Install R-Lang

Here are the steps to install R-lang on different operating systems:

#### Windows

1. Go to the [R for Windows page](https://cran.r-project.org/bin/windows/base/) on CRAN (Comprehensive R Archive Network).
2. Click on the "Download R x.x.x for Windows" link (where x.x.x represents the version number).
3. Click on the "install R for the first time" link.
4. Run the downloaded .exe file and follow the installation wizard.

#### macOS

1. Go to the [R for macOS page](https://cran.r-project.org/bin/macosx/) on CRAN.
2. Click on the "Download R-x.x.x.pkg" link (where x.x.x represents the version number).
3. Run the downloaded .pkg file and follow the installation wizard.

#### Linux

For Ubuntu and Debian-based systems:

1. Open a terminal window.
2. Enter the following command to add the CRAN repository to your sources list:

```
sudo sh -c 'echo "deb https://cran.rstudio.com/bin/linux/ubuntu $(lsb_release -cs)-cran40/" >> /etc/apt/sources.list'
```

3. Add the CRAN GPG key:

```
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
```

4. Update your package lists and install R:

```
sudo apt-get update
sudo apt-get install r-base
```

For other Linux distributions, refer to the documentation on the [R for Linux page](https://cran.r-project.org/bin/linux/).


### Installing Repository

1. Clone the repository

```
git clone https://github.com/Eggy115/R.git
```

2. Install required packages by running the following command in R console:

```
install.packages(c("package name"))
```

## Usage

### Running Scripts

1. Open R console or RStudio
2. Navigate to the directory containing the script
3. Run the script using the `source` command:

```
source("script_name.R")
```

### Running Programs

1. Open R console or RStudio
2. Navigate to the directory containing the program
3. Run the program using the `Rscript` command:

```
Rscript program_name.R
```

## Contributing

Contributions are always welcome! Here are some ways you can contribute:

1. Fork the repository and make your changes. 
2. Submit a pull request with your changes.
3. Create an issue if you find a bug or have a feature request.

Please make sure to adhere to the [code of conduct](CODE_OF_CONDUCT.md) and the [contributing guidelines](CONTRIBUTING.md).

## License

This project is licensed under the GPL v3 License - see the [LICENSE](LICENSE) file for details.

