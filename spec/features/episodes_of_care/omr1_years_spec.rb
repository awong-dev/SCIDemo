include Warden::Test::Helpers
Warden.test_mode!

# Feature: OMR 1 year Followup
#   As a user
#   I want to add or edit 1 year followup OMR entries per patient
#   So I can properly record this type of episode of care
feature 'OMR 1 Year Followup' do
  after(:each) do
    Warden.test_reset!
  end

  # Scenario: Add OMR 1 Year Followup to a patient
  #   Given I am a user
  #   When I add an OMR 1 Year Followup to a patient record
  #   Then return to the patient record and can see the newly created Annual
  #        Evaluation
  scenario 'Add OMR 1 Year Followup' do
    sign_in_user
    patient1 = create(:patient)
    visit edit_patient_path(patient1)

    expect(page).to have_content "Basic Patient Info"
    expect(page).to have_content patient1.ssn

    click_link("OMR 1 year")
    expect(page).to have_content "New OMR 1 Year Followup"

    fill_in "Episode date", with: Time.now

    click_button("Create Omr1 year")
    current_url.should == edit_patient_url(patient1)

    # TODO(awong.dev): Verify OMR 1 year shows.
  end
end
