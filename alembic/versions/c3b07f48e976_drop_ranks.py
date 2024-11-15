"""Drop ranks

Revision ID: c3b07f48e976
Revises: 562c41ca5879
Create Date: 2024-11-12 18:13:05.366900

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'c3b07f48e976'
down_revision = '562c41ca5879'
branch_labels = None
depends_on = None


def upgrade():
    # Drop the rank columns
    op.drop_column('lto_lifecycle', 'rank_status')
    op.drop_column('lto_lifecycle', 'rank_verify')
    op.drop_column('lto_lifecycle', 'rank_priority')
    op.drop_column('lto_lifecycle', 'rank_md5_comp')
    op.drop_column('lto_lifecycle', 'rank_character_check')


def downgrade():
    # Add the columns back in case of rollback
    op.add_column('lto_lifecycle', sa.Column(
        'rank_status', sa.String(length=255), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'rank_verify', sa.Boolean(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'rank_priority', sa.Integer(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'rank_md5_comp', sa.Boolean(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column(
        'rank_character_check', sa.Boolean(), nullable=True))
