resource "aws_route53_record" "sid_galaxie_family" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "sid.galaxie.family"
  type    = "A"
  ttl     = "86400"
  records = [
        "5.135.185.63",
      ]
}
resource "aws_route53_record" "sid_galaxie_family" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "sid.galaxie.family"
  type    = "AAAA"
  ttl     = "86400"
  records = [
        "2001:41d0:8:c23f::1",
      ]
}
resource "aws_route53_record" "sid_galaxie_family" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "sid.galaxie.family"
  type    = "MX"
  ttl     = "86400"
  records = [
        "[10, 'mail.sid.galaxie.family.']",
      ]
}
resource "aws_route53_record" "sid_galaxie_family" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "sid.galaxie.family"
  type    = "NS"
  ttl     = "86400"
  records = [
        "ns1.sid.galaxie.family.",
      ]
}
resource "aws_route53_record" "sid_galaxie_family" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "sid.galaxie.family"
  type    = "SOA"
  ttl     = "86400"
  records = [
        "ns1.sid.galaxie.family. hostmaster.sid.galaxie.family. 1590601687 86400 3600 604800 86400",
      ]
}
resource "aws_route53_record" "sid_galaxie_family" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "sid.galaxie.family"
  type    = "TXT"
  ttl     = "86400"
  records = [
        "v=spf1 mx -all",
      ]
}
resource "aws_route53_record" "acme_challenge_sid_galaxie_family" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "_acme-challenge.sid.galaxie.family"
  type    = "TXT"
  ttl     = "86400"
  records = [
        "cNGxdmCig6TrdCCiJj3qdmnEceQqAtqbUIL37WYpAgk",
      ]
}
resource "aws_route53_record" "dmarc_sid_galaxie_family" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "_dmarc.sid.galaxie.family"
  type    = "TXT"
  ttl     = "86400"
  records = [
        "v=DMARC1;p=reject;pct=20;rua=mailto:hostmaster@sid.galaxie.family;ruf=mailto:hostmaster@sid.galaxie.family;rf=afrf;aspf=r;adkim=r",
      ]
}
resource "aws_route53_record" "mail__domainkey_sid_galaxie_family" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "mail._domainkey.sid.galaxie.family"
  type    = "TXT"
  ttl     = "86400"
  records = [
        "v=DKIM1;h=sha256;k=rsa;p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDaQtj3w582QF3/bN0nIGsSEkuRpD/ckvVoS8fC/YenvHUFFjmcQB55eDDNo7nGInOIDa3kMohR/TMBL9FgsYrIrM2Gsld5FseRkfV1o5EB+hZhpdlWEn4u7Q2EpQ82HYBJdNpxZoRFQoUdpg9VIKPF9rIhn6S5peQyQVzIUwxJHwIDAQAB",
      ]
}
resource "aws_route53_record" "cal_sid_galaxie_family" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "cal.sid.galaxie.family"
  type    = "CNAME"
  ttl     = "86400"
  records = [
        "kimserver.sid.galaxie.family.",
      ]
}
resource "aws_route53_record" "acme_challenge_cal_sid_galaxie_family" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "_acme-challenge.cal.sid.galaxie.family"
  type    = "TXT"
  ttl     = "86400"
  records = [
        "VYcaT9uHs1FbpoenEHKl6CZSpHBuKMwZ03Libg_TxEc",
      ]
}
resource "aws_route53_record" "chat_sid_galaxie_family" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "chat.sid.galaxie.family"
  type    = "CNAME"
  ttl     = "86400"
  records = [
        "kimserver.sid.galaxie.family.",
      ]
}
resource "aws_route53_record" "acme_challenge_chat_sid_galaxie_family" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "_acme-challenge.chat.sid.galaxie.family"
  type    = "TXT"
  ttl     = "86400"
  records = [
        "-6pLozYSi8L4FmveWWePAtSqjC9udwcYkn-KaV1Ldm8",
      ]
}
resource "aws_route53_record" "kimserver_sid_galaxie_family" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "kimserver.sid.galaxie.family"
  type    = "A"
  ttl     = "86400"
  records = [
        "5.135.185.63",
      ]
}
resource "aws_route53_record" "kimserver_sid_galaxie_family" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "kimserver.sid.galaxie.family"
  type    = "AAAA"
  ttl     = "86400"
  records = [
        "2001:41d0:8:c23f::1",
      ]
}
resource "aws_route53_record" "acme_challenge_kimserver_sid_galaxie_family" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "_acme-challenge.kimserver.sid.galaxie.family"
  type    = "TXT"
  ttl     = "86400"
  records = [
        "c0HjkJa_3wDFFblCAE3RFzBWuu_kbHFhEXj2wMNGLGk",
      ]
}
resource "aws_route53_record" "mail_sid_galaxie_family" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "mail.sid.galaxie.family"
  type    = "A"
  ttl     = "86400"
  records = [
        "5.135.185.63",
      ]
}
resource "aws_route53_record" "mail_sid_galaxie_family" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "mail.sid.galaxie.family"
  type    = "AAAA"
  ttl     = "86400"
  records = [
        "2001:41d0:8:c23f::1",
      ]
}
resource "aws_route53_record" "acme_challenge_mail_sid_galaxie_family" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "_acme-challenge.mail.sid.galaxie.family"
  type    = "TXT"
  ttl     = "86400"
  records = [
        "f_OvfMnZw6bcFBElsQKjDILPhblSyrxg95zClC29JSc",
      ]
}
resource "aws_route53_record" "meet_sid_galaxie_family" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "meet.sid.galaxie.family"
  type    = "CNAME"
  ttl     = "86400"
  records = [
        "kimserver.sid.galaxie.family.",
      ]
}
resource "aws_route53_record" "acme_challenge_meet_sid_galaxie_family" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "_acme-challenge.meet.sid.galaxie.family"
  type    = "TXT"
  ttl     = "86400"
  records = [
        "f7K8YDD-g2isu9CyQvn8ImYwzanQbul6xFu4-YT3l60",
      ]
}
resource "aws_route53_record" "ns1_sid_galaxie_family" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "ns1.sid.galaxie.family"
  type    = "A"
  ttl     = "86400"
  records = [
        "5.135.185.63",
      ]
}
resource "aws_route53_record" "ns1_sid_galaxie_family" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "ns1.sid.galaxie.family"
  type    = "AAAA"
  ttl     = "86400"
  records = [
        "2001:41d0:8:c23f::1",
      ]
}
resource "aws_route53_record" "stun_sid_galaxie_family" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "stun.sid.galaxie.family"
  type    = "CNAME"
  ttl     = "86400"
  records = [
        "kimserver.sid.galaxie.family.",
      ]
}
resource "aws_route53_record" "acme_challenge_stun_sid_galaxie_family" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "_acme-challenge.stun.sid.galaxie.family"
  type    = "TXT"
  ttl     = "86400"
  records = [
        "U_Ai4olU0B8uALye18VVmZ_47nHJc3LjuLkvvi-0ADE",
      ]
}
