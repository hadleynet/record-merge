require File.expand_path("../../test_helper", __FILE__)

class SortTest < Test::Unit::TestCase

  def setup
    @fixtures_dir = File.expand_path("../../fixtures", __FILE__)
    teardown #get rid of anything left behind by last test run just in case
    @sorter = RecordMerge::Sorter.new(File.join(@fixtures_dir, 'tmp'))
  end
  
  def teardown
    Dir.glob(File.join(@fixtures_dir, 'tmp', '*')) do |file|
      puts "Removing: #{file}"
      FileUtils.rm_r(file)
    end
  end
  
  def test_dir_creation
    @sorter.sort(File.join(@fixtures_dir, 'NISTExampleC32.xml'))  
    assert File.exists?(File.join(@fixtures_dir, 'tmp', 'PatientID'))
    assert File.exists?(File.join(@fixtures_dir, 'tmp', 'PatientID', 'PatientID-20091110-080945-EST.xml'))
    assert File.symlink?(File.join(@fixtures_dir, 'tmp', 'PatientID', 'PatientID-20091110-080945-EST.xml'))
  end

end