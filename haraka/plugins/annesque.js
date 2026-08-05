
const BOUNCE = 'bounce'
const SIMPLE_API_TOKEN = process.env.SIMPLE_API_TOKEN
const ANNESQUE_ORIGIN  = process.env.ANNESQUE_ORIGIN

exports.hook_mail = async function (next, connection, params) {
  this.loginfo('+++ params', params[0])

  const sender_email = `${params[0].user}@${params[0].host}`.replace(/\+.*@/, "@").toLowerCase()
  this.loginfo('+++ sender_email: ', sender_email)

  try {
    let response = await fetch(`${ANNESQUE_ORIGIN}/wco/api/leads/by-email/${sender_email}?secret=${SIMPLE_API_TOKEN}`)
    if (!response.ok) {
      return next()
    }
    response = await response.json()
    this.loginfo('+++ lead from webui: ', response)

    const tags_slugs = response.tags.map(t => t.slug)
    if (tags_slugs.indexOf(BOUNCE) !== -1) {
      return next(DENY, "Denied due to policy.");
    }

    const leadset_tags_slugs = response.leadset.tags.map(t => t.slug)
    if (leadset_tags_slugs.indexOf(BOUNCE) !== -1) {
      return next(DENY, "Denied due to policy.");
    }

  } catch (err) {
    this.logerror(err)
    next()
  }

  next()
};
