[![Code Climate](https://codeclimate.com/github/andresbravog/active-model-union.png)](https://codeclimate.com/github/andresbravog/active-model-union)
[![Build Status](https://travis-ci.org/andresbravog/active-model-union.svg?branch=master)](https://travis-ci.org/andresbravog/active-model-union)

# `ActiveModelUnion::Base`

New `ActiveModel` class base that allows you to define `n` different `ActiveRecord` models to search from:

```Ruby
class User < ActiveRecord::Base
  attributte_accessor :name, :email, :login
end

class Organization < ActiveRecord::Base
  attributte_accessor :name, :email, :description
end

class YourNewClass < ActiveModelUnion::Base
  union_model :user, :organization

  union_attribute :name, :email, :login
end

YourNewClass.where(email: 'me@gmail.com' ).all
```

# `ActiveModelUnion::Relation`

Relation model that allows us to chain operations as union on to each one of the union models. Right now we have:

* where
* limit
* order
* joins
* count
* to_sql
* all
* paginate

We can aditionally make some of the operations just in one of the union models by using the `_in` methods:

```Ruby
YourNewClass.where_in(:user, email: 'me@gmail.com' ).all
```

right now we have:

* where_in
* joins_in

