class UsersIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      email: {
        tokenizer: 'keyword',
        filter: ['lowercase']
      }
    }
  }

  index_scope User
  field :name, type: :keyword
  field :email, analyzer: 'email'
  field :city_id, type: 'integer'
end
