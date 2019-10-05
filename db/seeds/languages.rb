# frozen_string_literal: true

langs = {
  'Ruby': 'ruby',
  'Javascript': 'javascript',
  'TypeScript': 'typescript',
  'Python': 'python',
  'PHP': 'php',
  'Perl': 'perl',
  'HTML': 'html',
  'XML': 'xml',
  'erb': 'html_ruby',
  'slim': 'slim',
  'CSS': 'css',
  'SCSS': 'scss',
  'SASS': 'sass',
  'stylus': 'stylus',
  'Java': 'java',
  'C': 'c',
  'C++': 'c_pp',
  'Go': 'golang',
  'Kotlin': 'kotlin',
  'Swift': 'swift',
  'Lisp': 'lisp',
  'Scala': 'scala',
  'COBOL': 'cobol',
  'SQL': 'sql',
  'MySQL': 'mysql',
  'PostgreSQL': 'pgsql',
  'SQLServer': 'sqlserver',
  'JSON': 'json',
  'Shell': 'sh'
}

languages = langs.map { |name, mode| Language.new(name: name, mode: mode) }
Language.import languages
