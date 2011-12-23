# Takes a set of source files as input, creates a new directory for each patient and saves
# JSON versions of those files into the appropriate directory named by patient id and date
module RecordMerge
  class Sorter
    def initialize(dest_dir)
      @dest_dir = dest_dir
    end
    
    def sort(file)
      doc = Nokogiri::XML(File.new(file))
      doc.root.add_namespace_definition('cda', 'urn:hl7-org:v3')
      patient = HealthDataStandards::Import::C32::PatientImporter.instance.parse_c32(doc)
      File.open(filename(patient),'w') do |file|
        file.write(patient.as_document.to_json)
      end
    end
    
    def filename(patient)
      dir = patient_dir(patient)
      effective_time = Time.at(patient.effective_time).strftime('%Y%m%d-%H%M%S-%Z')
      File.join(dir, "#{patient.medical_record_number}-#{effective_time}.json")
    end

    def patient_dir(patient)
      target_dir = File.join(@dest_dir, patient.medical_record_number)
      if !File.exists?(target_dir)
        Dir.mkdir(target_dir)
      end
      target_dir
    end
    
  end
end