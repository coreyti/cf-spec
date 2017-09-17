require 'openssl'

module CF::Spec
  module Resources
    class X509_Certificate < Base
      def initialize(backend, path)
        super
        @path = path
        @file = backend.file(path)
      end

      def certificate?
        ! cert.nil?
      end

      def exist?
        @file.exist?
      end

      def valid?
        return false unless certificate?
        range = (cert.not_before..cert.not_after)
        range.cover?(Time.now)
      end

      # ---

      def to_s
        inspect
      end

      def inspect
        "#<CF::Spec::Resources::X509_Certificate:0x#{self.__id__.to_s(16)} @backend=#{@backend.type} @path=#{@path}>"
      end

      private

      def cert
        @cert = begin
          OpenSSL::X509::Certificate.new @file.read
        rescue OpenSSL::X509::CertificateError
          nil
        end
      end
    end
  end
end
