module FunctionBin
  class User
    include DataMapper::Resource

    property :id,          Serial
    property :name,        String, :required => true
    property :email,       String, :unique_index => true
    property :created_at,  DateTime
    property :updated_at,  DateTime

    has n, :functions
    has n, :implementations
    has n, :upvotes

    def upvoted?(implementation)
      !!self.upvotes.first(:implementation_id => implementation.id)
    end
  end
end
