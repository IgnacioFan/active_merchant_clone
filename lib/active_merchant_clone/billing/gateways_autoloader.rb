module ActiveMerchantClone
  module Billing
    Dir[File.dirname(__FILE__) + "/gateways/**/*.rb"].each do |path|
      file_name = File.basename(path, ".rb")
      class_name = file_name.split("_").map(&:capitalize).join
      autoload(class_name, path)
    end
  end
end
