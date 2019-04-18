ThinkingSphinx::Index.define :campaign, :with => :active_record do
 
  indexes occ_type
  indexes name
  
  # Associated User
  indexes user.username, :sortable => true

  has user_id, created_at, updated_at
end