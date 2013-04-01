require 'digest/md5'
require 'fileutils'
require "persistent_memoize/version"

module PersistentMemoize
  # Memoize the method 'name', with results stored in files under 'path'
  def memoize(name, path)
    unless File.exists?(path)
      FileUtils.mkdir_p(path)
    end

    (class<<self; self; end).send(:define_method, name) do |*args|
      key = Digest::MD5.hexdigest(Marshal.dump(args))
      cacheFile = File.join(path, key)
      if File.exists?(cacheFile)
        results = File.open(cacheFile, 'rb'){ |f| Marshal.load(f) }
      else
        results = super(*args)
        File.open(cacheFile, 'wb'){ |f| Marshal.dump(results, f) }
      end
      results
    end

  end

end
