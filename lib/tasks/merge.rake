require File.expand_path("../../record-merge", __FILE__)

namespace :records do

  desc 'Merge multiple records per patient from source_dir into a single record per patient in dest_dir'
  task :merge, [:source_dir,:dest_dir] do |t, args|
    if !args.source_dir || args.source_dir.size==0
      raise "please specify a value for source_dir"
    end    
    if !args.dest_dir || args.dest_dir.size==0
      raise "please specify a value for source_dir"
    end
    processor = RecordMerge::Processor.new(args.source_dir, args.dest_dir)
    processor.merge
  end

end