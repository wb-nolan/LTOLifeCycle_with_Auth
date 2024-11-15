"""Version 2 Lto Lifecycle

Revision ID: 562c41ca5879
Revises: b89cd3fb0283
Create Date: 2024-11-12 18:04:09.568982

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '562c41ca5879'
down_revision = 'b89cd3fb0283'
branch_labels = None
depends_on = None


def upgrade():
    # Drop all columns except 'task_id' and 'hostname'
    op.drop_column('lto_lifecycle', 'lifecycle_status')
    op.drop_column('lto_lifecycle', 'priority')
    op.drop_column('lto_lifecycle', 'task_type')
    op.drop_column('lto_lifecycle', 'barcode')
    op.drop_column('lto_lifecycle', 'task_name')
    op.drop_column('lto_lifecycle', 'project')
    op.drop_column('lto_lifecycle', 'status')
    op.drop_column('lto_lifecycle', 'verify')
    op.drop_column('lto_lifecycle', 'process')
    op.drop_column('lto_lifecycle', 'progress')
    op.drop_column('lto_lifecycle', 'md5_comp')
    op.drop_column('lto_lifecycle', 'character_check')
    op.drop_column('lto_lifecycle', 'archive_comp')
    op.drop_column('lto_lifecycle', 'restore_comp')
    op.drop_column('lto_lifecycle', 'verify_comp')
    op.drop_column('lto_lifecycle', 'src_count')
    op.drop_column('lto_lifecycle', 'dest_count')
    op.drop_column('lto_lifecycle', 'src_size')
    op.drop_column('lto_lifecycle', 'destsize')
    op.drop_column('lto_lifecycle', 'date_added')
    op.drop_column('lto_lifecycle', 'date_modified')
    op.drop_column('lto_lifecycle', 'process_start')

    # Drop additional rank columns
    op.drop_column('lto_lifecycle', 'rank_status')
    op.drop_column('lto_lifecycle', 'rank_verify')
    op.drop_column('lto_lifecycle', 'rank_priority')
    op.drop_column('lto_lifecycle', 'rank_md5_comp')
    op.drop_column('lto_lifecycle', 'rank_character_check')


def downgrade():
    # Re-add the columns in case of rollback
    op.add_column('lto_lifecycle', sa.Column(
        'lifecycle_status', sa.String(length=255), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'priority', sa.Integer(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'task_type', sa.String(length=255), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'barcode', sa.String(length=255), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'task_name', sa.String(length=255), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'project', sa.String(length=255), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'status', sa.String(length=255), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'verify', sa.Boolean(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'process', sa.Boolean(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'progress', sa.Float(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'md5_comp', sa.Boolean(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'character_check', sa.Boolean(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'archive_comp', sa.Boolean(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'restore_comp', sa.Boolean(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'verify_comp', sa.Boolean(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'src_count', sa.Integer(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'dest_count', sa.Integer(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'src_size', sa.Integer(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'destsize', sa.Integer(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'date_added', sa.DateTime(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'date_modified', sa.DateTime(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'process_start', sa.DateTime(), nullable=True))

    # Re-add the rank columns in case of rollback
    op.add_column('lto_lifecycle', sa.Column(
        'rank_status', sa.Integer(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'rank_verify', sa.Integer(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'rank_priority', sa.Integer(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'rank_md5_comp', sa.Integer(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'rank_character_check', sa.Integer(), nullable=True))
