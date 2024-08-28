$env.config = {
  show_banner: false,
	table: {
	  mode: "compact_double",
		fizesize_format: "mb",
	}
}

$env.PATH = ($env.PATH | split row (char esep) | append /usr/bin/env)
