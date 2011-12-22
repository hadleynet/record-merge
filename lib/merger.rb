module RecordMerge
  class Merger
    def initialize(src_dir)
      @src_dir = src_dir
    end
    
    def sorted_files
      files = Dir.glob(File.join(@src_dir, '*.json'))
      files.sort!
    end
    
    def merge_all
      files = sorted_files
      start = load(sorted_files[0])
      sorted_files[1,-1].each do |file|
        delta = load(file)
        start = merge(start, delta)
      end
      start
    end
    
    def merge(start, delta)
      [:allergies, :care_goals, :conditions, :encounters, :immunizations, :medical_equipment,
   :medications, :procedures, :results, :social_history, :vital_signs].each do |section|
        delta.send(section).each do |entry|
          if !start.send(section).include?(entry)
            start.send(section) << entry
          end
        end
      end
      start
    end
    
    def load(file)
      patient_hash = JSON.parse(File.read(file))
      Record.new(patient_hash)
    end
    
  end
end