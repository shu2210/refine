# frozen_string_literal: true

langs = {
  'Ruby': 'ruby',
  'Python': 'python',
  'Perl': 'perl',
  'Java': 'java',
  'JavaScript': 'javascript',
  'C': 'c',
  'C++': 'cpp',
  'Go': 'go',
  'Kotlin': 'kotlin',
  'Swift': 'swift',
  'Lisp': 'lisp',
  'Scala': 'scala'
}

languages = langs.map { |name, mode| Language.new(name: name, mode: mode) }
Language.import languages
