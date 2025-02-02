# frozen_string_literal: true

module SEPA
  class IBANValidator < ActiveModel::Validator
    # IBAN2007Identifier (taken from schema)
    REGEX = /\A[A-Z]{2,2}[0-9]{2,2}[a-zA-Z0-9]{1,30}\z/.freeze

    def validate(record)
      field_name = options[:field_name] || :iban
      value = record.send(field_name).to_s

      record.errors.add(field_name, :invalid, message: options[:message]) unless value.match(REGEX)
    end
  end

  class BICValidator < ActiveModel::Validator
    # AnyBICIdentifier (taken from schema)
    REGEX = /\A[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}\z/.freeze

    def validate(record)
      field_name = options[:field_name] || :bic
      value = record.send(field_name)

      record.errors.add(field_name, :invalid, message: options[:message]) if value && !value.to_s.match(REGEX)
    end
  end

  class CreditorIdentifierValidator < ActiveModel::Validator
    REGEX = %r{\A[a-zA-Z]{2,2}[0-9]{2,2}([A-Za-z0-9]|[+|?|/|\-|:|(|)|.|,|']){3,3}([A-Za-z0-9]|[+|?|/|\-|:|(|)|.|,|']){1,28}\z}.freeze

    def validate(record)
      field_name = options[:field_name] || :creditor_identifier
      value = record.send(field_name)

      record.errors.add(field_name, :invalid, message: options[:message]) unless valid?(value)
    end

    def valid?(creditor_identifier)
      if ok = creditor_identifier.to_s.match(REGEX) && creditor_identifier[0..1].match(/DE/i)
        # In Germany, the identifier has to be exactly 18 chars long
        ok = creditor_identifier.length == 18
      end
      ok
    end
  end

  class MandateIdentifierValidator < ActiveModel::Validator
    REGEX = %r{\A([A-Za-z0-9]|[+|?|/|\-|:|(|)|.|,|']){1,35}\z}.freeze

    def validate(record)
      field_name = options[:field_name] || :mandate_id
      value = record.send(field_name)

      record.errors.add(field_name, :invalid, message: options[:message]) unless value.to_s.match(REGEX)
    end
  end
end
