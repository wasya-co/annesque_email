
const BOUNCE = 'bounce'
const SIMPLE_API_TOKEN = process.env.SIMPLE_API_TOKEN
const ANNESQUE_ORIGIN  = process.env.ANNESQUE_ORIGIN
const addressparser = require('address-rfc2822')

/*
 * executes first
**/
exports.hook_mail = async function (next, connection, params) {
  this.loginfo('+++ params: ', params[0])

  const mail_from = `${params[0].user}@${params[0].host}`.replace(/\+.*@/, "@").toLowerCase()
  this.loginfo('+++ mail_from: ', mail_from)

  try {
    let response = await fetch(`${ANNESQUE_ORIGIN}/wco/api/leads/by-email/${mail_from}?secret=${SIMPLE_API_TOKEN}`)
    if (!response.ok) { return next() }
    response = await response.json()
    this.loginfo('+++ lead from webui: ', JSON.stringify(response))

    const tags_slugs = response.tags.map(t => t.slug)
    // connection.transaction.notes.tags_slugs = tags_slugs
    if (tags_slugs.indexOf(BOUNCE) !== -1) {
      return next(DENY, "Denied due to policy.");
    }

    const leadset_tags_slugs = response.leadset.tags.map(t => t.slug)
    // connection.transaction.notes.leadset_tags_slugs = leadset_tags_slugs
    if (leadset_tags_slugs.indexOf(BOUNCE) !== -1) {
      return next(DENY, "Denied due to policy.");
    }

  } catch (err) {
    this.logerror(err)
    next()
  }

  next()
};


exports.hook_data_post = async function (next, connection) {
  const from = connection.transaction.header.get('From')
  if (!from) { return next() }

  const parsed = addressparser.parse(from)
  if (!parsed.length || !parsed[0].address) { return next() }

  const sender_email = parsed[0].address.replace(/\+.*@/, "@").toLowerCase() // regular from
  this.loginfo(`+++ sender_email: ${sender_email}`)

  try {
    let response = await fetch(`${ANNESQUE_ORIGIN}/wco/api/leads/by-email/${sender_email}?secret=${SIMPLE_API_TOKEN}`)
    if (!response.ok) { return next() }

    response = await response.json()
    this.loginfo(`+++ lead from webui: ${JSON.stringify(response)}`)

    const tags_slugs = response.tags.map(t => t.slug)
    if (tags_slugs.includes(BOUNCE)) {
      return next(DENY, 'Denied due to policy.')
    }

    const leadset_tags_slugs = response.leadset.tags.map(t => t.slug)
    if (leadset_tags_slugs.includes(BOUNCE)) {
      return next(DENY, 'Denied due to policy.')
    }

    next()
  }
  catch (err) {
    this.logerror(err)
    next()
  }
};


