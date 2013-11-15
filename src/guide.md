% Opener Installation Guide
% Yorick Peterse <yorickpeterse@olery.com>
% November 15th, 2013

\pagebreak

# Preface

This guide covers the various steps needed to get the different Opener
components up and running. It discusses the process of installing the various
programming languages/environments needed, their required versions and so
forth.

The source code of this guide can be found at
<https://github.com/opener-project/installation-guide> and is maintained by
Olery. The guide is available in HTML and PDF format, see the Git repository
for corresponding download links.

\pagebreak

# Operating System Requirements

The Opener components assume a Unix like operating system, or at least a system
that's compatible with the [POSIX][posix] standard. If you're using Windows you
should look into either using a virtual machine or using [MinGW][mingw] or
[Cygwin][cygwin].

Linux users are advised to run recent versions of the Linux kernel, though
there's no hard requirement for this. OS X users are advised to run at least OS
X Lion.

The various Opener components have been tested on various versions of Ubuntu,
OS X Mavericks/Mountain Lion, Arch Linux and Debian. They should work fine on
at least these operating systems.

\pagebreak

# Java Setup

Some components, such as NER and the language identifier require Java. To
ensure that all components work without having to install a handful of
different Java versions the minimum required version is set to Java 1.7,
OpenJDK is recommended instead of the Oracle/Sun JDK.

On most, if not all, Linux distributions you can install the OpenJDK by running
one of the following commands:

    sudo pacman -S jdk7-openjdk         # Arch Linux
    sudo apt-get install openjdk-7-jdk  # Debian
    sudo yum install java-1.7.0-openjdk # CentOS

In case your distribution supports the installation of multiple Java versions
(e.g. CentOS) you'll want to make sure that Java 1.7 is the default. On CentOS
you can do so by running the following command:

    sudo update-alternatives --config java

Then choose the 1.7 version of Java.

For OS X a bit of extra work is required as some versions ship 1.6 and others
come with 1.7. In case your Java version is not 1.7 (you can check this by
running `java -version`) you'll have to update it. To install/update Java you
have to download the right installer from
<http://www.oracle.com/technetwork/java/javase/downloads/index.html> and run
it.

To confirm that you're running the right Java version, run the following
command:

    java -version

The output should look similar to the following:

    java version "1.7.0_45"
    OpenJDK Runtime Environment (IcedTea 2.4.3) (ArchLinux build 7.u45_2.4.3-1-x86_64)
    OpenJDK 64-Bit Server VM (build 24.45-b08, mixed mode)

The most important bit is the first line as this specifies the Java version,
everything else is platform/JDK specific and thus can vary.

\pagebreak

# Python Setup

Components such as the POS tagger base and opinion detector base need Python to
function properly. The minimum required Python version is Python 2.7. Most
Linux distributions already ship Python 2.7. If not you can install it as
following:

    sudo pacman -S python2      # Arch Linux
    sudo apt-get install python # Debian
    sudo yum install python27   # CentOS
    brew install python         # OS X with Homebrew

## Virtualenv Setup

Due to Python often being used for system components (e.g. the Yum package
manager is written in Python) and often requiring specific versions (e.g. Yum
requires Python 2.6) it's recommended that you use [virtualenv][virtualenv].

To install virtualenv you should first install pip, this can be done by running
one of the following commands:

    sudo pacman -S python2-pip      # Arch Linux
    sudo apt-get install python-pip # Debian
    sudo yum install python-pip     # CentOS

When using Homebrew on OS X the `python` package installs Pip automatically.

Then install virtualenv:

    sudo pip2 install virtualenv # Arch Linux
    sudo pip install virtualenv  # Most other systems

\pagebreak

## Creating Virtual Envs

Create a virtual environment called `opener`:

    virtualenv --python=/path/to/python27 ~/.virtualenvs/opener

The `--python` option is used to specify what base Python to use, it should be
the full path to the Python 2.7 binary. You can find the location of this
binary by running one of the following two commands:

    which python2 # Arch Linux
    which python  # Most other systems

As an example:

    virtualenv --python=/usr/bin/python2 ~/.virtualenvs/opener

To activate the virtual environment run the following:

    source ~/.virtualenvs/opener/bin/activate

To confirm you're using the right Python version run the following:

    which python

The resulting path should point to bin/python in the virtual environment
created above. For example, on my system the output is as following:

    /home/yorickpeterse/.virtualenvs/opener/bin/python

\pagebreak

# Perl

Currently two components, the base tokenizer and French tokenizer, require Perl
5 to be installed. The minimum required Perl version is Perl 5.10.

Since these components vendor their dependencies the process of getting Perl up
and running is fairly simple.

On various Linux distributions you can install Perl as following (if not
already present):

    sudo pacman -S perl       # Arch Linux
    sudo apt-get install perl # Debian
    sudo yum install perl     # CentOS

OS X already has Perl installed so no extra steps are needed.

\pagebreak

# Ruby

All components are wrapped a Ruby package and distributed on
[RubyGems][rubygems]/Olery's private Geminabox server. The minimum required
Ruby version is Ruby 1.9.3.

Due to different distributions often shipping different (sometimes outdated)
Ruby versions and the need to, at least in the future, also run [Jruby][jruby]
Rubies should be installed using [ruby-install][ruby-install] and
[chruby][chruby]. Another popular tool is [RVM][rvm], though RVM adds quite
some complexity that is often not needed.

## chruby & ruby-install Installation

ruby-install can be installed as following:

    wget -O ruby-install-0.3.1.tar.gz \
      https://github.com/postmodern/ruby-install/archive/v0.3.1.tar.gz

    tar -xzvf ruby-install-0.3.1.tar.gz
    cd ruby-install-0.3.1/
    sudo make install

chruby in turn can be installed as following:

    wget -O chruby-0.3.7.tar.gz \
      https://github.com/postmodern/chruby/archive/v0.3.7.tar.gz

    tar -xzvf chruby-0.3.7.tar.gz
    cd chruby-0.3.7/
    sudo make install

If you're using Homebrew on OS X you can install these tools as following:

    brew install ruby-install
    brew install chruby

On Arch Linux you can install them as following from the AUR:

    yaourt -S chruby ruby-install-git

Upon completion add the following line to your `~/.bashrc` or `~/.profile`
file:

    source /usr/local/share/chruby/chruby.sh

On Arch Linux (and possibly other distributions) you have to use the following
instead:

    source /usr/share/chruby/chruby.sh

## Installing Ruby Versions

Create the directory for your Ruby versions:

    mkdir -p ~/.rubies

Now we can install Ruby 1.9.3:

    ruby-install ruby 1.9.3 --install-dir=~/.rubies/ruby-1.9.3

Reload your shell:

    source ~/.bashrc # or ~/.profile if the former doesn't exist

Switch to the right Ruby version:

    chruby 1.9.3

You can test the setup by running the following two commands:

    which ruby
    ruby --version

On my machine the output is as following:

    /home/yorickpeterse/.rubies/ruby-1.9.3-p448/bin/ruby
    ruby 1.9.3p448 (2013-06-27 revision 41675) [x86_64-linux]

\pagebreak

# RubyGems

RubyGems is the package manager of Ruby and is used to distribute the Opener
components. Currently these are hosted on <https://geminabox.olery.com/> but in
the future they'll be moved to the public [RubyGems][rubygems] repository.

To install Gems from Olery's private Gem server you first have to run the
following command to tell RubyGems where to find the packages:

    # Make sure there's no whitespace in the password
    gem sources --add "https://opener:Aek0YeeGup0ceephohcieW0eichiGha2Thoo"\
    "0lohshunae9emaikeitainooleap@geminabox.olery.com"

    gem sources --update

Once set up you can, for example, install the tokenizer:

    gem install opener-tokenizer

Once set up you should install some base Gems that are used throughout the
various components:

    gem install rake bundler

[posix]: https://en.wikipedia.org/wiki/POSIX
[mingw]: http://mingw.org/
[cygwin]: http://cygwin.com/
[virtualenv]: http://www.virtualenv.org/en/latest/
[rubygems]: https://rubygems.org/
[jruby]: http://jruby.org/
[ruby-install]: https://github.com/postmodern/ruby-install
[chruby]: https://github.com/postmodern/chruby
[rvm]: http://rvm.io/
