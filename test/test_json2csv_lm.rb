require 'minitest/autorun'
require_relative '../lib/json2csv_lm.rb'

describe Json2csvLm do

  before do
    input_filepath = File.expand_path("test_given.json", File.dirname(__FILE__))
    @output_filepath = File.expand_path("path_test/output.csv", File.dirname(__FILE__))

    # Delete the result of the last test
    File.delete(@output_filepath) if File.exist?(@output_filepath)

    # running the convert method to be able to test the result (the output.csv file)
    Json2csvLm.convert(input_filepath, @output_filepath)

    # parsing the 2 files (output.csv & expected_out.csv) to compare their content
    @parsing_result = []
    CSV.foreach(@output_filepath) { |row| @parsing_result << row }

    @expected_parsing_result = []
    expected_output_filepath = File.expand_path( "expected_output.csv" , File.dirname(__FILE__))
    CSV.foreach(expected_output_filepath) { |row| @expected_parsing_result << row }
  end

  describe "#convert" do
    it "should create a csv file at the right location (output_filepath)" do
      assert_equal( true, File.exist?(@output_filepath))
    end

    it "should create a csv file with the same content as the expected one" do
      @parsing_result.must_equal(@expected_parsing_result)
    end
  end

  describe "#parse_json_file" do
    it "should return an array" do
      assert_kind_of(Array, Json2csvLm.parse_json_file(File.expand_path("test_given.json", File.dirname(__FILE__))))
    end
  end
end
