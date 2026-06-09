from PIL import Image, ImageDraw, ImageFont
import os

WIDTH = 1700
HEIGHT = 2200
MARGIN = 80
FONT_SIZE = 32
SMALL_FONT = 26
CAPTION_FONT = 28
TITLE_FONT = 42
LINE = 4

try:
    FONT = ImageFont.truetype('Arial.ttf', FONT_SIZE)
    FONT_BOLD = ImageFont.truetype('Arial Bold.ttf', TITLE_FONT)
    SMALL = ImageFont.truetype('Arial.ttf', SMALL_FONT)
    CAPTION = ImageFont.truetype('Arial.ttf', CAPTION_FONT)
except Exception:
    FONT = ImageFont.load_default()
    FONT_BOLD = ImageFont.load_default()
    SMALL = ImageFont.load_default()
    CAPTION = ImageFont.load_default()


def measure_text(draw, text, font):
    bbox = draw.textbbox((0, 0), text, font=font)
    return bbox[2] - bbox[0], bbox[3] - bbox[1]


def draw_box(draw, xy, label, fill='#F0F8FF', outline='#000000'):
    draw.rectangle(xy, fill=fill, outline=outline, width=3)
    x0, y0, x1, y1 = xy
    text_w, text_h = measure_text(draw, label, font=FONT)
    draw.text(((x0 + x1 - text_w) / 2, (y0 + y1 - text_h) / 2), label, fill='black', font=FONT)


def draw_arrow(draw, start, end):
    draw.line([start, end], fill='black', width=4)
    dx = end[0] - start[0]
    dy = end[1] - start[1]
    dist = (dx * dx + dy * dy) ** 0.5
    if dist == 0:
        return
    ux = dx / dist
    uy = dy / dist
    ax = end[0] - ux * 30
    ay = end[1] - uy * 30
    left = (ax - uy * 12, ay + ux * 12)
    right = (ax + uy * 12, ay - ux * 12)
    draw.polygon([end, left, right], fill='black')


def text_wrap(draw, text, font, max_width):
    words = text.split(' ')
    lines = []
    current = ''
    for w in words:
        test = current + (' ' if current else '') + w
        if measure_text(draw, test, font=font)[0] <= max_width:
            current = test
        else:
            lines.append(current)
            current = w
    if current:
        lines.append(current)
    return lines


def make_page(title, content_lines, draw_func):
    img = Image.new('RGB', (WIDTH, HEIGHT), 'white')
    draw = ImageDraw.Draw(img)
    draw.text((MARGIN, MARGIN), title, fill='black', font=FONT_BOLD)
    draw_func(draw)

    caption_y = HEIGHT - 420
    caption_title = 'Caption:'
    draw.text((MARGIN, caption_y), caption_title, fill='black', font=FONT_BOLD)
    caption_y += 60
    for line in text_wrap(draw, content_lines, CAPTION, WIDTH - 2 * MARGIN):
        draw.text((MARGIN, caption_y), line, fill='black', font=CAPTION)
        caption_y += CAPTION_FONT + 10
    return img


def page1(draw):
    draw.text((MARGIN, 120), 'Current Local Architecture', fill='black', font=FONT_BOLD)
    # draw boxes
    draw_box(draw, (MARGIN + 100, 260, WIDTH - 150, 420), 'Local Machine\n(single host)')
    draw_box(draw, (MARGIN + 120, 520, 820, 760), 'Flask Application\n- API routes\n- Templates\n- Static assets\n- Upload folder')
    draw_box(draw, (900, 520, WIDTH - 120, 760), 'SQLite Database\n- local file store')
    draw_box(draw, (MARGIN + 120, 820, 820, 980), 'Static assets\nCSS/JS/images')
    draw_box(draw, (900, 820, WIDTH - 120, 980), 'Upload folder\nuser-generated files')
    # arrows
    draw_arrow(draw, (WIDTH/2, 420), (WIDTH/2, 520))
    draw_arrow(draw, (820, 640), (900, 640))
    draw_arrow(draw, (WIDTH/2, 760), (WIDTH/2, 820))
    draw_arrow(draw, (WIDTH/2, 760), (WIDTH/2 + 80, 820))
    draw.text((MARGIN + 120, 1030), 'Component classification: Compute = Flask app, Database = SQLite, Storage = static/upload files, Networking = local interface', fill='black', font=SMALL)


def page2(draw):
    draw.text((MARGIN, 120), 'Proposed Google Cloud Architecture', fill='black', font=FONT_BOLD)
    # network boundary
    draw.rectangle((MARGIN + 60, 260, WIDTH - 90, 1680), outline='#0072C6', width=6)
    draw.text((MARGIN + 80, 270), 'VPC Network with public and private subnets', fill='#0072C6', font=SMALL)
    # public
    draw_box(draw, (MARGIN + 140, 340, WIDTH - 260, 520), 'External HTTPS Load Balancer\n(public)')
    # private compute
    draw_box(draw, (MARGIN + 140, 560, WIDTH - 260, 840), 'Managed Instance Group\n(Compute Engine VMs)\nPrivate subnet')
    draw_box(draw, (MARGIN + 140, 900, WIDTH - 260, 1180), 'Cloud SQL (Private IP)\nPrivate subnet')
    draw_box(draw, (MARGIN + 140, 1240, WIDTH - 260, 1420), 'Cloud Storage Bucket\nprivate uploads + static assets')
    # arrows
    draw_arrow(draw, ((WIDTH/2), 520), ((WIDTH/2), 560))
    draw_arrow(draw, ((WIDTH/2), 840), ((WIDTH/2), 900))
    draw_arrow(draw, ((WIDTH/2), 840), ((WIDTH/2), 1240))
    draw_arrow(draw, (WIDTH/2, 150), (WIDTH/2, 340))
    draw.text((MARGIN + 120, 1460), 'Security boundaries: only LB public, app and DB in private subnets, firewall rules restrict access.', fill='black', font=SMALL)


def page3(draw):
    draw.text((MARGIN, 120), 'Component-to-Service Mapping', fill='black', font=FONT_BOLD)
    top = 220
    lefts = [MARGIN + 40, 580, 1000, 1420]
    widths = [520, 360, 360, 260]
    headers = ['Component', 'Service Category', 'Proposed GCP Service', 'Justification']
    for idx, h in enumerate(headers):
        draw.rectangle((lefts[idx], top, lefts[idx] + widths[idx], top + 90), fill='#DCE6F1', outline='black', width=3)
        tw, th = measure_text(draw, h, font=FONT)
        draw.text((lefts[idx] + 10, top + (90 - th) / 2), h, fill='black', font=FONT)
    rows = [
        ('Flask App', 'Compute', 'Compute Engine', 'Runs containerized application workloads on managed VMs in a private subnet.'),
        ('SQLite DB', 'Database', 'Cloud SQL', 'Replaces local file database with managed relational storage, enabling durability and HA.'),
        ('Static assets', 'Storage', 'Cloud Storage', 'Stores web assets and uploads with durable object storage and IAM control.'),
        ('Upload folder', 'Storage', 'Cloud Storage', 'Provides scalable file persistence separated from compute lifecycle.'),
        ('API routes', 'Networking', 'HTTPS Load Balancer', 'Fronts private compute with a managed public ingress point and traffic distribution.'),
    ]
    y = top + 90
    for row in rows:
        hgt = 100
        draw.rectangle((lefts[0], y, lefts[0] + widths[0], y + hgt), outline='black', width=2)
        draw.rectangle((lefts[1], y, lefts[1] + widths[1], y + hgt), outline='black', width=2)
        draw.rectangle((lefts[2], y, lefts[2] + widths[2], y + hgt), outline='black', width=2)
        draw.rectangle((lefts[3], y, lefts[3] + widths[3], y + hgt), outline='black', width=2)
        draw.text((lefts[0] + 10, y + 20), row[0], fill='black', font=FONT)
        draw.text((lefts[1] + 10, y + 20), row[1], fill='black', font=FONT)
        draw.text((lefts[2] + 10, y + 20), row[2], fill='black', font=FONT)
        lines = text_wrap(draw, row[3], SMALL, widths[3] - 20)
        ly = y + 10
        for line in lines:
            draw.text((lefts[3] + 10, ly), line, fill='black', font=SMALL)
            ly += SMALL_FONT + 4
        y += hgt


def page4(draw):
    draw.text((MARGIN, 120), 'Distributed Systems Risk Analysis', fill='black', font=FONT_BOLD)
    entries = [
        ('Scenario A: DB zone failure', 'A private Cloud SQL zone outage makes the application lose writes and reads. CAP: consistency prioritized by managed SQL, so availability drops during failover. Mitigation: use regional Cloud SQL, multi-AZ failover, and replicas to improve availability without sacrificing data consistency.'),
        ('Scenario B: 10× traffic spike', 'A single VM cannot absorb sudden demand and becomes overloaded. Autoscaling and load balancing distribute requests across multiple instances, scaling compute capacity while preserving responsiveness.'),
        ('Network partition', 'A VPC or backend failure can isolate compute from DB/storage. Mitigation: private service connectivity, firewall health checks, and retry logic reduce impact from transient partitions.'),
    ]
    y = 220
    for title, body in entries:
        draw.rectangle((MARGIN + 20, y, WIDTH - MARGIN - 20, y + 240), outline='black', width=3)
        draw.text((MARGIN + 50, y + 20), title, fill='black', font=FONT)
        lines = text_wrap(draw, body, SMALL, WIDTH - 2 * MARGIN - 80)
        ly = y + 80
        for line in lines:
            draw.text((MARGIN + 50, ly), line, fill='black', font=SMALL)
            ly += SMALL_FONT + 8
        y += 260


def page5(draw):
    draw.text((MARGIN, 120), 'Architecture Decision Record (ADR)', fill='black', font=FONT_BOLD)
    decisions = [
        ('Decision: Use Compute Engine with private managed instance group.', 'Context: The app is a small Flask service currently on a single local host.', 'Alternatives: Cloud Run, GKE, App Engine.', 'Trade-off: Compute Engine gives explicit networking and private subnet control at the cost of more infrastructure management.'),
        ('Decision: Replace SQLite with Cloud SQL.', 'Context: SQLite is local and not durable across cloud VMs.', 'Alternatives: keep SQLite on the VM, use Cloud Spanner, use Firestore.', 'Trade-off: Cloud SQL incurs managed service cost but provides backups, private networking, and HA.'),
        ('Decision: Store uploads and static assets in Cloud Storage.', 'Context: Local files on the VM do not scale or survive instance replacement.', 'Alternatives: keep file storage on VM disk or use a shared filesystem.', 'Trade-off: Cloud Storage is highly durable and decouples storage from compute, while requiring application changes for object access.'),
    ]
    y = 220
    for title, ctx, alt, trade in decisions:
        draw.rectangle((MARGIN + 20, y, WIDTH - MARGIN - 20, y + 300), outline='black', width=3)
        draw.text((MARGIN + 50, y + 20), title, fill='black', font=FONT)
        for label, text in [('Context:', ctx), ('Alternatives:', alt), ('Trade-off:', trade)]:
            draw.text((MARGIN + 50, y + 80 if label == 'Context:' else y + (135 if label == 'Alternatives:' else 190)), label, fill='black', font=SMALL)
            wrapped = text_wrap(draw, text, SMALL, WIDTH - 2 * MARGIN - 100)
            ly = y + (115 if label == 'Context:' else 165 if label == 'Alternatives:' else 220)
            for line in wrapped:
                draw.text((MARGIN + 70, ly), line, fill='black', font=SMALL)
                ly += SMALL_FONT + 6
        y += 320


def main():
    pages = []
    pages.append(make_page('Screenshot 1: Current Local Architecture Diagram', 'This diagram shows the single-host CloudNotes deployment with the Flask application, SQLite database, static assets, templates, uploads, and local networking all contained on one machine.', page1))
    pages.append(make_page('Screenshot 2: Proposed Cloud Architecture Diagram', 'This proposed GCP architecture puts the public ingress on an HTTPS Load Balancer, and places the application tier, database tier, and storage inside private networks with firewall protections.', page2))
    pages.append(make_page('Screenshot 3: Component-to-Service Mapping Table', 'This table maps each CloudNotes component to its service category and proposed GCP service with engineering justification for each choice.', page3))
    pages.append(make_page('Screenshot 4: Distributed Systems Risk Analysis', 'This analysis covers database zone failure, traffic spikes, and network partition risks with CAP reasoning and mitigation strategies for a cloud deployment.', page4))
    pages.append(make_page('Screenshot 5: Architecture Decision Record (ADR)', 'This ADR records the major design decisions, context, alternatives considered, and trade-offs for the chosen cloud architecture.', page5))
    pdf_path = 'cloudnotes-architecture-planning-.pdf'
    pages[0].save(pdf_path, 'PDF', resolution=100.0, save_all=True, append_images=pages[1:])
    print(f'Generated {pdf_path}')

if __name__ == '__main__':
    main()
