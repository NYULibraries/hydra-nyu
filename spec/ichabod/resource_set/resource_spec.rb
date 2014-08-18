require 'spec_helper'
module Ichabod
  module ResourceSet
    describe Resource do
      subject(:resource) { create :resource }
      it { should be_a Resource }
      its(:prefix) { should eq 'prefix' }
      describe '#pid' do
        subject { resource.pid }
        it { should eq "#{resource.prefix}:#{resource.identifier.first}"}
        context 'when the identifier has "."s' do
          let(:resource) { create :resource, identifier: 'this.has.dots' }
          it { should_not include '.' }
          it { should eq 'prefix:this-has-dots'}
        end
        context 'when the identifier has "/"s' do
          let(:resource) { create :resource, identifier: 'this/has/slashes' }
          it { should_not include '/' }
          it { should eq 'prefix:this-has-slashes'}
        end
        context 'when the identifier has "\"s' do
          let(:resource) { create :resource, identifier: 'this\has\backslashes' }
          it { should_not include '\\' }
          it { should eq 'prefix:this-has-backslashes'}
        end
        context 'when the identifier has "http://"s' do
          let(:resource) { create :resource, identifier: 'this\has\http://handle' }
          it { should_not include 'http://' }
          it { should eq 'prefix:this-has-handle'}
        end
      end
      describe '#to_nyucore' do
        subject { resource.to_nyucore }
        it { should be_an Nyucore }
        it { should_not be_persisted }
        it 'should have a pid' do
          expect(subject.pid).to be_present
        end
      end
      describe '#to_s' do
        subject { resource.to_s }
        it { should be_a String }
        it { should_not be_empty }
        it 'should include the title' do
          expect(subject).to include "pid: #{resource.pid}"
        end
        it 'should include the first title' do
          expect(subject).to include "title: #{resource.title.first}"
        end
      end
    end
  end
end