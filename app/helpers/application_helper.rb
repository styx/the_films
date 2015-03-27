module ApplicationHelper
  def inline_svg(name)
    File.open(Rails.root.join('app/assets/images/', "#{name}.svg"), 'rb') do |f|
      raw f.read
    end
  end
end
