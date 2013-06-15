RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    # DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.around(:each, :testing_transactions => true) do |ex|
    DatabaseCleaner.strategy = nil
    ex.run
    DatabaseCleaner.strategy = :truncation
  end

end
