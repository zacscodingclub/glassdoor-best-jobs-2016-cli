class Job
  attr_accessor :rank, :title, :openings, :median_base_salary, :market_size
  @@all = []

  def initialize(jobs_array)
    jobs_array.each do |k, v|
      self.send(("#{k}="), v)
    end

    @@all << self
    calc_market_size
  end

  def calc_market_size
    @@all.each do |job|
      job.market_size = job.openings * job.median_base_salary
    end
  end

  def self.all
    @@all
  end

  def self.total_openings
    self.all.collect { |job_doc| job_doc.openings }.reduce(:+)
  end

  def self.total_market_size
    self.all.collect { |job_doc| job_doc.market_size }.reduce(:+)
  end

  def self.management_positions
    self.all.select { |job_doc| job_doc.title.include?("Manager") }
  end

  def self.sort_by_most_openings
    sorted = self.all.sort_by { |job_doc| job_doc.openings }.reverse
  end

  def self.sort_by_base_salary
    sorted = self.all.sort_by { |job_doc| job_doc.median_base_salary }.reverse
  end

  def self.sort_by_rank
    sorted = self.all.sort_by { |job_doc| job_doc.rank }
  end

  def self.sort_by_title
    sorted = self.all.sort_by { |job_doc| job_doc.title }
  end

  def self.sort_by_market_size
    sorted = self.all.sort_by { |job_doc| job_doc.market_size }.reverse
  end

  def self.search_by_title(title)
    select_few = self.all.select do |job_doc|
      job_doc.title.include?(title.capitalize)
    end
  end
end