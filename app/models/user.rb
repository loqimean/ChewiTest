class User < ApplicationRecord
  update_index('users') { self }
end
