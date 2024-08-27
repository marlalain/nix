$env.config = {
  show_banner: false,
}

$env.PATH = ($env.PATH | split row (char esep) | append /usr/bin/env)
