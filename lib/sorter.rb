# Takes a set of files as input, creates a new directory for each patient and links
# associated files into each directory named by patient id and date
module RecordMerge
  class Sorter
    def initialize(dest_dir)
      @dest_dir = dest_dir
    end
    
    def sort(file)
      doc = Nokogiri::XML(File.new(file))
      doc.root.add_namespace_definition('cda', 'urn:hl7-org:v3')
      patient = HealthDataStandards::Import::C32::PatientImporter.instance.parse_c32(doc)
      dir = patient_dir(patient)
      new_file = File.join(dir, File.basename(file))
      File.symlink(file, new_file)
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