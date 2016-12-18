# accountabilities
bank, agent, client accountabilities

# TODO
- реализовать кейсы проверки прав через связки
  - пользователь обладает ролью текущей организации

# Валидация разрешенных типов для связок

Гем store_base_sti_class решает проблему ограничения классов, с которыми может
работать accountability. Он кладет в accountabilities#parent_type
Bank, Agent, Client, а не Organization. И потому можно вводить валидатор:

```organization_user.rb
  validates :parent_type, inclusion: {in: %w[Bank Client Agent]}
```

Однако появляется другая проблема:

```user.rb
  has_many :organizations, through: :organization_users, source: :parent,
    source_type: 'Bank'
```

необходимо указывать source_type: 'Bank' (а не 'Organization'), т.е. тот
класс, с которым по факту связан пользователь.

Это неудобно, т.к. в кейсах нам по идее надо просто получать список организаций,
неважно какой роли (это нужно проверить!).

Можно собственно-ручный валидатор

```
  validate :foo
  def foo
    parent.is_a?(Bank)
  end
```
