require 'spec_helper'
describe NyuPressOpenAccessBook do
  let(:prefix) { 'nyupress' }
  let(:endpoint_url) { 'http://openaccessbooks.nyupress.org/sources/discovery.json' }
  let(:collection_code) { 'nyupress' }
  let(:args) { [endpoint_url].compact }
  subject(:nyu_press_open_access_book) { NyuPressOpenAccessBook.new(*args) }
  it { should be_a NyuPressOpenAccessBook }
  it { should be_a Ichabod::ResourceSet::Base }
  its(:prefix) { should eq prefix }
  its(:endpoint_url) { should eq endpoint_url }
  its(:collection_code) { should eq collection_code }
  its(:editors) { should eq ['admin_group'] }
  its(:before_loads) { should eq [:add_edit_groups, :add_resource_set] }
  describe '.prefix' do
    subject { NyuPressOpenAccessBook.prefix }
    it { should eq prefix }
  end
  describe '.source_reader' do
    subject { NyuPressOpenAccessBook.source_reader }
    #it 'should be a DLTS reader'
    it { should eq Ichabod::ResourceSet::SourceReaders::NyuPressOpenAccessBookReader }
  end
  describe '.editors' do
    subject { NyuPressOpenAccessBook.editors }
    it { should eq [:admin_group] }
  end
  describe '.before_loads' do
    subject { NyuPressOpenAccessBook.before_loads }
    it { should eq [:add_edit_groups, :add_resource_set] }
  end
end
