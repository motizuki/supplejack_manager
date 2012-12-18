class Parser
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  VALID_STRATEGIES = ["json", "oai", "rss", "xml"]

  class << self
    def repository
      @repo ||= Grit::Repo.new(ENV["PARSER_GIT_REPO_PATH"])
    end

    def head
      repository.commits.first
    end

    def tree
      head.tree
    end

    def build
      
    end

    def find(path)
      path.gsub!(/-/, "/")
      blob = tree / path
      segments = path.split("/")
      new(blob, segments[0])
    end

    def all
      parsers = []
      tree.contents.each do |content|
        if content.respond_to?(:contents) && VALID_STRATEGIES.include?(content.name)
          content.contents.each do |blob|
            parsers << Parser.new(blob, content.name)
          end
        end
      end

      parsers
    end
  end

  attr_reader :blob, :strategy, :name
  attr_accessor :data

  def initialize(blob, strategy)
    @blob = blob
    @name = blob.name
    @data = blob.data
    @strategy = strategy
  end

  def to_param
    "#{strategy}-#{name}"
  end

  def persisted?
    false
  end
end