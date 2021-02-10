# == Pry-Nav - Using pry as a debugger ==
Pry.commands.alias_command 'c', 'continue' rescue nil
Pry.commands.alias_command 's', 'step' rescue nil
Pry.commands.alias_command 'n', 'next' rescue nil

# === CUSTOM PROMPT ===
# This prompt shows the ruby version
if defined?(Pry::Prompt) # Pry >= 0.13.0
  Pry::Prompt.add(
    :rb_version,
    'ruby version prompt',
  ) do |context, nesting, pry, separator|
    format(
      '%<name>s@%<version>s(%<context>s)%<nesting>s%<separator>s ',
      name: pry.config.prompt_name,
      version: RUBY_VERSION,
      context: Pry.view_clip(context),
      nesting: (nesting > 0 ? ":#{nesting}" : ''),
      separator: separator
    )
  end
  Pry.config.prompt = Pry::Prompt[:rb_version]
else
  Pry.config.prompt = [
    proc { |obj, nesting, pry| "#{pry.config.prompt_name}@#{RUBY_VERSION}(#{Pry.view_clip(obj)})#{":#{nesting}" unless nesting.zero?}> " },
    proc { |obj, nesting, pry| "#{pry.config.prompt_name}@#{RUBY_VERSION}(#{Pry.view_clip(obj)})#{":#{nesting}" unless nesting.zero?}* " },
  ]
end

# === Listing config ===
# Better colors - by default the headings for methods are too 
# similar to method name colors leading to a "soup"
# These colors are optimized for use with Solarized scheme 
# for your terminal
Pry.config.ls.separator = "\n" # new lines between methods
Pry.config.ls.heading_color = :magenta
Pry.config.ls.public_method_color = :green
Pry.config.ls.protected_method_color = :yellow
Pry.config.ls.private_method_color = :bright_black

# == PLUGINS ===
# awesome_print gem: great syntax colorized printing
# look at ~/.aprc for more settings for awesome_print
begin
  require 'awesome_print'
  # The following line enables awesome_print for all pry output,
  # and it also enables paging
  Pry.config.print = proc {|output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output)}

  # If you want awesome_print without automatic pagination, use the line below
  # Pry.config.print = proc { |output, value| output.puts value.ai }
rescue LoadError => err
  # puts "gem install awesome_print  # <-- highly recommended"
end

default_command_set = Pry::CommandSet.new do
  command "caller_method" do |depth|
    depth = depth.to_i || 1
    if /^(.+?):(\d+)(?::in `(.*)')?/ =~ caller(depth+1).first
      file   = Regexp.last_match[1]
      line   = Regexp.last_match[2].to_i
      method = Regexp.last_match[3]
      output.puts [file, line, method]
    end
  end
end

Pry.config.commands.import default_command_set
