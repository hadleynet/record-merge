require File.expand_path("../../test_helper", __FILE__)

class SortTest < Test::Unit::TestCase

  def setup
    @fixtures_dir = File.expand_path("../../fixtures", __FILE__)
    teardown #get rid of anything left behind by last test run just in case
    tmp_dir = File.join(@fixtures_dir, 'tmp')
    if (!File.exists?(tmp_dir))
      Dir.mkdir(tmp_dir)
    end
    @sorter = RecordMerge::Sorter.new(tmp_dir)
  end
  
  def teardown
    Dir.glob(File.join(@fixtures_dir, 'tmp', '*')) do |file|
      FileUtils.rm_r(file)
    end
  end
  
  def test_dir_creation
    assert !File.exists?(File.join(@fixtures_dir, 'tmp', 'PatientID'))
    @sorter.sort(File.join(@fixtures_dir, 'NISTExampleC32.xml'))  
    assert File.exists?(File.join(@fixtures_dir, 'tmp', 'PatientID'))
    file = File.join(@fixtures_dir, 'tmp', 'PatientID', 'PatientID-20091110-080945-EST.json')
    assert File.exists?(file)
    patient_hash = JSON.parse(File.read(file))
    assert_equal 'PatientID', patient_hash['medical_record_number']
    record = Record.new(patient_hash)
    assert_equal 'PatientID', record.medical_record_number
  end

end