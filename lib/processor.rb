module RecordMerge
  class Processor
    def initialize(source_dir, dest_dir)
      @source_dir = get_dir(source_dir)
      @dest_dir = get_dir(dest_dir)
    end
    
    def merge
      sorter = RecordMerge::Sorter.new(@dest_dir)
      Dir.glob(File.join(@source_dir, '*.*')).each do |file|
        sorter.sort(file)
      end
      
      Dir.glob(File.join(@dest_dir, '*')) do |dir|
        if File.directory?(dir)
          merger = RecordMerge::Merger.new(dir)
          record = merger.merge_all
          filename = File.join(@dest_dir, "#{record.medical_record_number}-merged.json")
          File.open(filename,'w') do |file|
            file.write(record.as_document.to_json)
          end
        end
      end
    end

    private
    
    def get_dir(dir)
      if !File.exists?(dir)
        dir = File.join(Dir.pwd, dir)
      end
      if !File.directory?(dir)
        raise "#{dir} is not a directory"
      end
      dir
    end
  
  end  
end