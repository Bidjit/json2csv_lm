require 'json'
require 'csv'

class Json2csvLm
  def self.convert(input_filepath, output_filepath = nil)
    unless File.exist?(input_filepath)
      puts "Error: File not found"
      return nil
    end
    begin
      content_hashes = parse_json_file(input_filepath)
      content_strings_arrays = hashes_to_strings_arrays(content_hashes)
      # TODO for next line
        # file exist ? if yes => erasable/writable/accessGranted ? if no => handle the case
          # begin rescue sur l'appel de storecsv
      # For now .convert will create or overwrite output.csv in th same dir than input_filepath
      storecsv("#{File.dirname(input_filepath)}/output.csv", content_strings_arrays)
    rescue => e
      e.inspect
    end
  end

  private

  # Parsing JSON
  def self.parse_json_file(filepath)
    serialized_content = File.read(filepath)
    content_hashes_array = JSON.parse(serialized_content)

    if content_hashes_array.length == 0
      raise "No object in the json file, operation aborted"
    else
      return content_hashes_array
    end
  end


  # Building the headers array
  def self.extract_headers(hash, current_header = "")
    res = []
    hash.each do |k, v|
      new_header = current_header.empty? ? k : "#{current_header}.#{k}"
      if v.is_a?(Hash)
        res += extract_headers(v, new_header)
      else
        res << new_header
      end
    end
    return res
  end

  # Constructing an array of row_contents
  def self.hashes_to_strings_arrays(hashes_array)
    res = []
    headers = extract_headers(hashes_array.first)
    res << headers
    hashes_array.each do |hash|
      row_content = []
      headers.each do |header|
        value = hash.dig(*header.split("."))
        # array values transformation
        if value.is_a?(Array)
          # In case of value = [] :
          if value.length > 0
            row_content << value.join("|")
          else
            # we want nothing between the delimiters in the csv (,,) not double doublequote (,"",)
            row_content << nil
          end
        else
          row_content << value
        end
      end
      res << row_content
    end
    return res
      # rescue => e
      #   puts e.class
      #   puts "Error: #{e.message}"
      #   puts "All objects of the file must have the same schema "
      #   # Kernel.exit
      #   return nil
      # end
  end

  # Storing CSV
  def self.storecsv(filepath, array)
    csv_options = { col_sep: ',', force_quotes: false }

    CSV.open(filepath, 'w+', csv_options) do |csv|
      array.each do |row_content|
        csv << row_content
      end
    end
  end
end
