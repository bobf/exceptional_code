require 'logger'

class RecordProcessor
  def initialize
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::DEBUG
    @storage = { people: [] }
  end

  def process_records(records)
    @logger.info('processing records')
    records.each { |record| process_record(record) }
    @logger.info('finished processing')
  end

  def process_record(record)
    name = retrieve(:name, record)
    town = retrieve(:town, record)
    if name.nil? || town.nil?
      @logger.warn('missing fields, skipping record')
    else
      save_record(name, town)
      @logger.info("record saved: #{record}")
    end
  end

  def retrieve(field, record)
    record.fetch(field)
  rescue KeyError => e
    handle_error(field, record, e)
    nil
  end

  def save_record(name, town)
    @storage.fetch(:people).push(name: name, town: town)
  end

  def handle_error(field, record, e)
    source = e.backtrace.first
    @logger.debug(
      "#{source}: Error fetching #{field} from #{record}: #{e.inspect}"
    )
  end
end

records = [
  { name: 'john', town: 'london' },
  { name: 'chris', twon: 'chichester' },
  { name: 'andrew', town: 'bristol' }
]


RecordProcessor.new.process_records(records)
