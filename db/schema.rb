# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140626225327) do

  create_table "calls", force: true do |t|
    t.string   "number"
    t.integer  "legislator_id"
    t.integer  "signature_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "survey_body"
    t.string   "sid"
    t.boolean  "ended"
    t.integer  "call_duration"
  end

  add_index "calls", ["legislator_id"], name: "index_calls_on_legislator_id"
  add_index "calls", ["signature_id"], name: "index_calls_on_signature_id"

  create_table "legislators", force: true do |t|
    t.string   "zipcode"
    t.text     "representation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "body"
    t.string   "bioguide_id"
    t.string   "title"
    t.string   "gender"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "congress_office"
    t.string   "state"
    t.string   "party"
    t.string   "district"
    t.string   "senate_class"
    t.string   "phone"
    t.string   "fax"
    t.string   "email"
    t.string   "twitter_id"
    t.string   "votesmart_id"
    t.string   "website"
    t.string   "webform"
    t.string   "youtube_url"
    t.string   "congresspedia_url"
    t.string   "facebook_id"
    t.string   "fec_id"
    t.string   "govtrack_id"
  end

  add_index "legislators", ["zipcode"], name: "index_legislators_on_zipcode"

  create_table "signatures", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "zipcode"
    t.text     "change_org_error"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "city"
  end

end
