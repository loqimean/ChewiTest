class UsersIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      name: {
        tokenizer: 'keyword',
        filter: ['lowercase']
      },
      email: {
        tokenizer: 'keyword',
        filter: ['lowercase']
      }
    }
  }

  index_scope User
  field :name, analyzer: 'name'
  field :email, analyzer: 'email'
  field :city_id, type: 'integer'
  field :seniority, type: 'keyword'
  field :updated_at, type: 'date'
end
