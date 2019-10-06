# frozen_string_literal: true

tags = []
tags << Tag.new(name: 'Ruby')
tags << Tag.new(name: 'Rails')
tags << Tag.new(name: 'Spring')
tags << Tag.new(name: 'Java')

Tag.import tags
