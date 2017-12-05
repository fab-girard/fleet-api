describe CurrentLocationPolicy, basic: true do

  before(:all) do
    @company = create(:company, name: 'mapo-company')
    @user = create(:user, company: @company)

    @current_location = create(:current_location, company: @company, user: @user, locationDetail: {
      lat: Random.rand(43.0..50.0),
      lon: Random.rand(-2.0..6.0),
      date: Time.now.strftime('%FT%T.%L%:z')
    })

    @other_company = create(:company, name: 'mapo-company')
    @other_user = create(:user, company: @other_company)
  end

  context 'for a visitor' do
    let(:current_user) { nil }
    let(:user) { nil }

    subject { CurrentLocationPolicy.new(user, @current_location) }

    it { should_not grant(:show) }
  end

  context 'for another user from other company' do
    let(:user) { @other_user }

    subject { CurrentLocationPolicy.new(user, @current_location) }

    it { should_not grant(:show) }
  end

  context 'for the current user' do
    let(:user) { @user }

    subject { CurrentLocationPolicy.new(user, @current_location) }

    it { should grant(:show) }
  end

end