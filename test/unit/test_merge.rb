require File.expand_path("../../test_helper", __FILE__)

class MergeTest < Test::Unit::TestCase

  def setup
    @sort_dir = File.expand_path("../../fixtures/sort", __FILE__)
    @merger = RecordMerge::Merger.new(@sort_dir)
  end
  
  def test_file_sorting
    files = @merger.sorted_files
    assert_equal 4, files.length
    assert_equal 'a-0000-EST.json', File.basename(files[0])
    assert_equal 'a-1020-EST.json', File.basename(files[1])
    assert_equal 'a-1021-EST.json', File.basename(files[2])
    assert_equal 'a-2000-EST.json', File.basename(files[3])
  end
  
  def test_merging
    merged = @merger.merge_all
    assert_equal 3, merged.allergies.size
    assert_equal 5, merged.conditions.size
  end

end