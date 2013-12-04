module FunctionBin
  class Function
    include DataMapper::Resource

    property :id,          Serial
    property :user_id,     Integer, :required => true, :index => true
    property :name,        String,  :unique_index => true
    property :description, String
    property :example,     Text
    property :created_at,  DateTime
    property :updated_at,  DateTime

    belongs_to :user
    has n, :implementations
  end
end
