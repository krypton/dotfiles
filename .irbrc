# configure autocomplete dialog colors
if defined? Reline::Face
  Reline::Face.config(:completion_dialog) do |conf|
    conf.define(:default, foreground: '#e0def4', background: '#232136')
    conf.define(:enhanced, foreground: '#3e8fb0', background: '#44415a')
    conf.define(:scrollbar, foreground: '#ea9a97', background: '#232136')
  end
end
