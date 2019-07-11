-- Table: accounts
DROP TABLE IF EXISTS accounts;

CREATE TABLE accounts (
    id                        INTEGER       PRIMARY KEY AUTOINCREMENT
                                            NOT NULL,
    name                      VARCHAR (255),
    hashed_password           VARCHAR (255),
    salt                      VARCHAR (255),
    created_at                DATETIME,
    updated_at                DATETIME,
    default_audio_language    VARCHAR (255),
    default_subtitle_language VARCHAR (255),
    auto_select_subtitle      BOOLEAN       DEFAULT 't',
    auto_select_audio         BOOLEAN       DEFAULT 't'
);


-- Table: blobs
DROP TABLE IF EXISTS blobs;

CREATE TABLE blobs (
    id          INTEGER       PRIMARY KEY AUTOINCREMENT
                              NOT NULL,
    blob        BLOB,
    linked_type VARCHAR (255),
    linked_id   INTEGER,
    linked_guid VARCHAR (255),
    created_at  DATETIME
);


-- Table: cloudsync_files
DROP TABLE IF EXISTS cloudsync_files;

CREATE TABLE cloudsync_files (
    id                INTEGER       PRIMARY KEY AUTOINCREMENT
                                    NOT NULL,
    device_identifier VARCHAR (255),
    original_url      VARCHAR (255),
    provider          VARCHAR (255),
    new_key           VARCHAR (255),
    query_string      VARCHAR (255),
    extra_data        VARCHAR (255) 
);


-- Table: devices
DROP TABLE IF EXISTS devices;

CREATE TABLE devices (
    id         INTEGER       PRIMARY KEY AUTOINCREMENT
                             NOT NULL,
    identifier VARCHAR (255),
    name       VARCHAR (255),
    created_at DATETIME,
    updated_at DATETIME,
    platform   STRING
);


-- Table: directories
DROP TABLE IF EXISTS directories;

CREATE TABLE directories (
    id                  INTEGER       PRIMARY KEY AUTOINCREMENT
                                      NOT NULL,
    library_section_id  INTEGER,
    parent_directory_id INTEGER,
    path                VARCHAR (255),
    created_at          DATETIME,
    updated_at          DATETIME,
    deleted_at          DATETIME
);


-- Table: external_metadata_items
DROP TABLE IF EXISTS external_metadata_items;

CREATE TABLE external_metadata_items (
    id                          INTEGER,
    external_metadata_source_id INTEGER,
    library_section_id          INTEGER,
    metadata_type               INTEGER,
    guid                        VARCHAR (255),
    title                       VARCHAR (255),
    parent_title                VARCHAR (255),
    year                        INTEGER,
    added_at                    INTEGER,
    updated_at                  INTEGER,
    FOREIGN KEY (
        external_metadata_source_id
    )
    REFERENCES external_metadata_sources (id) ON DELETE CASCADE
);


-- Table: external_metadata_sources
DROP TABLE IF EXISTS external_metadata_sources;

CREATE TABLE external_metadata_sources (
    id           INTEGER       PRIMARY KEY AUTOINCREMENT
                               NOT NULL,
    uri          VARCHAR (255),
    source_title VARCHAR (255),
    user_title   VARCHAR (255),
    online       INTEGER
);


-- Table: fts4_metadata_titles
DROP TABLE IF EXISTS fts4_metadata_titles;

CREATE VIRTUAL TABLE fts4_metadata_titles USING fts4 (
    content = 'metadata_items',
    title,
    title_sort,
    original_title
);


-- Table: fts4_metadata_titles_docsize
DROP TABLE IF EXISTS fts4_metadata_titles_docsize;

CREATE TABLE fts4_metadata_titles_docsize (
    docid INTEGER PRIMARY KEY,
    size  BLOB
);


-- Table: fts4_metadata_titles_segdir
DROP TABLE IF EXISTS fts4_metadata_titles_segdir;

CREATE TABLE fts4_metadata_titles_segdir (
    level            INTEGER,
    idx              INTEGER,
    start_block      INTEGER,
    leaves_end_block INTEGER,
    end_block        INTEGER,
    root             BLOB,
    PRIMARY KEY (
        level,
        idx
    )
);


-- Table: fts4_metadata_titles_segments
DROP TABLE IF EXISTS fts4_metadata_titles_segments;

CREATE TABLE fts4_metadata_titles_segments (
    blockid INTEGER PRIMARY KEY,
    block   BLOB
);


-- Table: fts4_metadata_titles_stat
DROP TABLE IF EXISTS fts4_metadata_titles_stat;

CREATE TABLE fts4_metadata_titles_stat (
    id    INTEGER PRIMARY KEY,
    value BLOB
);


-- Table: fts4_tag_titles
DROP TABLE IF EXISTS fts4_tag_titles;

CREATE VIRTUAL TABLE fts4_tag_titles USING fts4 (
    content = 'tags',
    tag
);


-- Table: fts4_tag_titles_docsize
DROP TABLE IF EXISTS fts4_tag_titles_docsize;

CREATE TABLE fts4_tag_titles_docsize (
    docid INTEGER PRIMARY KEY,
    size  BLOB
);


-- Table: fts4_tag_titles_segdir
DROP TABLE IF EXISTS fts4_tag_titles_segdir;

CREATE TABLE fts4_tag_titles_segdir (
    level            INTEGER,
    idx              INTEGER,
    start_block      INTEGER,
    leaves_end_block INTEGER,
    end_block        INTEGER,
    root             BLOB,
    PRIMARY KEY (
        level,
        idx
    )
);


-- Table: fts4_tag_titles_segments
DROP TABLE IF EXISTS fts4_tag_titles_segments;

CREATE TABLE fts4_tag_titles_segments (
    blockid INTEGER PRIMARY KEY,
    block   BLOB
);


-- Table: fts4_tag_titles_stat
DROP TABLE IF EXISTS fts4_tag_titles_stat;

CREATE TABLE fts4_tag_titles_stat (
    id    INTEGER PRIMARY KEY,
    value BLOB
);


-- Table: library_section_permissions
DROP TABLE IF EXISTS library_section_permissions;

CREATE TABLE library_section_permissions (
    id                 INTEGER PRIMARY KEY AUTOINCREMENT
                               NOT NULL,
    library_section_id INTEGER,
    account_id         INTEGER,
    permission         INTEGER
);


-- Table: library_sections
DROP TABLE IF EXISTS library_sections;

CREATE TABLE library_sections (
    id                      INTEGER       PRIMARY KEY AUTOINCREMENT
                                          NOT NULL,
    library_id              INTEGER,
    name                    VARCHAR (255),
    name_sort               VARCHAR (255) COLLATE NOCASE,
    section_type            INTEGER,
    language                VARCHAR (255),
    agent                   VARCHAR (255),
    scanner                 VARCHAR (255),
    user_thumb_url          VARCHAR (255),
    user_art_url            VARCHAR (255),
    user_theme_music_url    VARCHAR (255),
    public                  BOOLEAN,
    created_at              DATETIME,
    updated_at              DATETIME,
    scanned_at              DATETIME,
    display_secondary_level BOOLEAN,
    user_fields             VARCHAR (255),
    query_xml               TEXT,
    query_type              INTEGER,
    uuid                    VARCHAR (255),
    changed_at              INTEGER (8)   DEFAULT 0
);


-- Table: library_timeline_entries
DROP TABLE IF EXISTS library_timeline_entries;

CREATE TABLE library_timeline_entries (
    id                 INTEGER  PRIMARY KEY AUTOINCREMENT
                                NOT NULL,
    library_section_id INTEGER,
    metadata_item_id   INTEGER,
    state              INTEGER,
    updated_at         DATETIME
);


-- Table: locatables
DROP TABLE IF EXISTS locatables;

CREATE TABLE locatables (
    id                INTEGER       PRIMARY KEY AUTOINCREMENT
                                    NOT NULL,
    location_id       INTEGER       NOT NULL,
    locatable_id      INTEGER       NOT NULL,
    locatable_type    VARCHAR (255) NOT NULL,
    created_at        DATETIME,
    updated_at        DATETIME,
    extra_data        VARCHAR (255),
    geocoding_version INTEGER,
    UNIQUE (
        location_id,
        locatable_id,
        locatable_type
    )
);


-- Table: location_places
DROP TABLE IF EXISTS location_places;

CREATE TABLE location_places (
    id          INTEGER       PRIMARY KEY AUTOINCREMENT
                              NOT NULL,
    location_id INTEGER,
    guid        VARCHAR (255) NOT NULL,
    UNIQUE (
        location_id,
        guid
    )
);


-- Table: locations
DROP TABLE IF EXISTS locations;

CREATE VIRTUAL TABLE locations USING rtree (
    'id' integer,
    'lat_min' float,
    'lat_max' float,
    'lon_min' float,
    'lon_max' float
);


-- Table: locations_node
DROP TABLE IF EXISTS locations_node;

CREATE TABLE locations_node (
    nodeno INTEGER PRIMARY KEY,
    data   BLOB
);


-- Table: locations_parent
DROP TABLE IF EXISTS locations_parent;

CREATE TABLE locations_parent (
    nodeno     INTEGER PRIMARY KEY,
    parentnode INTEGER
);


-- Table: locations_rowid
DROP TABLE IF EXISTS locations_rowid;

CREATE TABLE locations_rowid (
    rowid  INTEGER PRIMARY KEY,
    nodeno INTEGER
);


-- Table: media_grabs
DROP TABLE IF EXISTS media_grabs;

CREATE TABLE media_grabs (
    id                    INTEGER       PRIMARY KEY AUTOINCREMENT
                                        NOT NULL,
    uuid                  VARCHAR (255),
    status                INTEGER,
    error                 INTEGER,
    metadata_item_id      INTEGER,
    media_subscription_id INTEGER,
    extra_data            VARCHAR (255),
    created_at            DATETIME,
    updated_at            DATETIME
);


-- Table: media_item_settings
DROP TABLE IF EXISTS media_item_settings;

CREATE TABLE media_item_settings (
    id            INTEGER       PRIMARY KEY AUTOINCREMENT
                                NOT NULL,
    account_id    INTEGER,
    media_item_id INTEGER,
    settings      VARCHAR (255),
    created_at    DATETIME,
    updated_at    DATETIME
);


-- Table: media_items
DROP TABLE IF EXISTS media_items;

CREATE TABLE media_items (
    id                      INTEGER       PRIMARY KEY AUTOINCREMENT
                                          NOT NULL,
    library_section_id      INTEGER,
    section_location_id     INTEGER,
    metadata_item_id        INTEGER,
    type_id                 INTEGER,
    width                   INTEGER,
    height                  INTEGER,
    size                    INTEGER (8),
    duration                INTEGER,
    bitrate                 INTEGER,
    container               VARCHAR (255),
    video_codec             VARCHAR (255),
    audio_codec             VARCHAR (255),
    display_aspect_ratio    FLOAT,
    frames_per_second       FLOAT,
    audio_channels          INTEGER,
    interlaced              BOOLEAN,
    source                  VARCHAR (255),
    hints                   VARCHAR (255),
    display_offset          INTEGER,
    settings                VARCHAR (255),
    created_at              DATETIME,
    updated_at              DATETIME,
    optimized_for_streaming BOOLEAN,
    deleted_at              DATETIME,
    media_analysis_version  INTEGER       DEFAULT 0,
    sample_aspect_ratio     FLOAT,
    extra_data              VARCHAR (255),
    proxy_type              INTEGER,
    channel_id              INTEGER,
    begins_at               DATETIME,
    ends_at                 DATETIME
);


-- Table: media_metadata_mappings
DROP TABLE IF EXISTS media_metadata_mappings;

CREATE TABLE media_metadata_mappings (
    id            INTEGER       PRIMARY KEY AUTOINCREMENT
                                NOT NULL,
    media_guid    VARCHAR (255),
    metadata_guid VARCHAR (255),
    created_at    DATETIME,
    updated_at    DATETIME
);


-- Table: media_part_settings
DROP TABLE IF EXISTS media_part_settings;

CREATE TABLE media_part_settings (
    id                          INTEGER       PRIMARY KEY AUTOINCREMENT
                                              NOT NULL,
    account_id                  INTEGER,
    media_part_id               INTEGER,
    selected_audio_stream_id    INTEGER,
    selected_subtitle_stream_id INTEGER,
    settings                    VARCHAR (255),
    created_at                  DATETIME,
    updated_at                  DATETIME,
    changed_at                  INTEGER (8)   DEFAULT 0
);


-- Table: media_parts
DROP TABLE IF EXISTS media_parts;

CREATE TABLE media_parts (
    id                 INTEGER       PRIMARY KEY AUTOINCREMENT
                                     NOT NULL,
    media_item_id      INTEGER,
    directory_id       INTEGER,
    hash               VARCHAR (255),
    open_subtitle_hash VARCHAR (255),
    file               VARCHAR (255),
    [index]            INTEGER,
    size               INTEGER (8),
    duration           INTEGER,
    created_at         DATETIME,
    updated_at         DATETIME,
    deleted_at         DATETIME,
    extra_data         VARCHAR (255) 
);


-- Table: media_provider_resources
DROP TABLE IF EXISTS media_provider_resources;

CREATE TABLE media_provider_resources (
    id           INTEGER       PRIMARY KEY AUTOINCREMENT
                               NOT NULL,
    parent_id    INTEGER,
    type         INTEGER,
    status       INTEGER,
    state        INTEGER,
    identifier   VARCHAR (255),
    protocol     VARCHAR (255),
    uri          VARCHAR (255),
    uuid         VARCHAR (255),
    extra_data   VARCHAR (255),
    last_seen_at DATETIME,
    created_at   DATETIME,
    updated_at   DATETIME,
    data         BLOB
);


-- Table: media_stream_settings
DROP TABLE IF EXISTS media_stream_settings;

CREATE TABLE media_stream_settings (
    id              INTEGER       PRIMARY KEY AUTOINCREMENT
                                  NOT NULL,
    account_id      INTEGER,
    media_stream_id INTEGER,
    extra_data      VARCHAR (255),
    created_at      DATETIME,
    updated_at      DATETIME,
    UNIQUE (
        media_stream_id,
        account_id
    )
);


-- Table: media_streams
DROP TABLE IF EXISTS media_streams;

CREATE TABLE media_streams (
    id             INTEGER       PRIMARY KEY AUTOINCREMENT
                                 NOT NULL,
    stream_type_id INTEGER,
    media_item_id  INTEGER,
    url            VARCHAR (255),
    codec          VARCHAR (255),
    language       VARCHAR (255),
    created_at     DATETIME,
    updated_at     DATETIME,
    [index]        INTEGER,
    media_part_id  INTEGER,
    channels       INTEGER,
    bitrate        INTEGER,
    url_index      INTEGER,
    [default]      BOOLEAN       DEFAULT 0,
    forced         BOOLEAN       DEFAULT 0,
    extra_data     VARCHAR (255) 
);


-- Table: media_subscriptions
DROP TABLE IF EXISTS media_subscriptions;

CREATE TABLE media_subscriptions (
    id                         INTEGER       PRIMARY KEY AUTOINCREMENT
                                             NOT NULL,
    [order]                    FLOAT,
    metadata_type              INTEGER,
    target_metadata_item_id    INTEGER,
    target_library_section_id  INTEGER,
    target_section_location_id INTEGER,
    extra_data                 VARCHAR (255),
    created_at                 DATETIME,
    updated_at                 DATETIME
);


-- Table: metadata_item_accounts
DROP TABLE IF EXISTS metadata_item_accounts;

CREATE TABLE metadata_item_accounts (
    id               INTEGER PRIMARY KEY AUTOINCREMENT
                             NOT NULL,
    account_id       INTEGER,
    metadata_item_id INTEGER
);


-- Table: metadata_item_clusterings
DROP TABLE IF EXISTS metadata_item_clusterings;

CREATE TABLE metadata_item_clusterings (
    id                       INTEGER PRIMARY KEY AUTOINCREMENT
                                     NOT NULL,
    metadata_item_id         INTEGER,
    metadata_item_cluster_id INTEGER,
    [index]                  INTEGER,
    version                  INTEGER,
    FOREIGN KEY (
        metadata_item_cluster_id
    )
    REFERENCES metadata_item_clusters (id) ON DELETE CASCADE,
    FOREIGN KEY (
        metadata_item_id
    )
    REFERENCES metadata_items (id) ON DELETE CASCADE
);


-- Table: metadata_item_clusters
DROP TABLE IF EXISTS metadata_item_clusters;

CREATE TABLE metadata_item_clusters (
    id                 INTEGER       PRIMARY KEY AUTOINCREMENT
                                     NOT NULL,
    zoom_level         INTEGER,
    library_section_id INTEGER,
    title              VARCHAR (255),
    count              INTEGER,
    starts_at          DATETIME,
    ends_at            DATETIME,
    extra_data         VARCHAR (255) 
);


-- Table: metadata_item_settings
DROP TABLE IF EXISTS metadata_item_settings;

CREATE TABLE metadata_item_settings (
    id              INTEGER       PRIMARY KEY AUTOINCREMENT
                                  NOT NULL,
    account_id      INTEGER,
    guid            VARCHAR (255),
    rating          FLOAT,
    view_offset     INTEGER,
    view_count      INTEGER,
    last_viewed_at  DATETIME,
    created_at      DATETIME,
    updated_at      DATETIME,
    skip_count      INTEGER       DEFAULT 0,
    last_skipped_at DATETIME      DEFAULT NULL,
    changed_at      INTEGER (8)   DEFAULT 0,
    extra_data      VARCHAR (255) 
);


-- Table: metadata_item_views
DROP TABLE IF EXISTS metadata_item_views;

CREATE TABLE metadata_item_views (
    id                      INTEGER       PRIMARY KEY AUTOINCREMENT
                                          NOT NULL,
    account_id              INTEGER,
    guid                    VARCHAR (255),
    metadata_type           INTEGER,
    library_section_id      INTEGER,
    grandparent_title       VARCHAR (255),
    parent_index            INTEGER,
    parent_title            VARCHAR (255),
    [index]                 INTEGER,
    title                   VARCHAR (255),
    thumb_url               VARCHAR (255),
    viewed_at               DATETIME,
    grandparent_guid        VARCHAR (255),
    originally_available_at DATETIME,
    device_id               INTEGER
);


-- Table: metadata_items
DROP TABLE IF EXISTS metadata_items;

CREATE TABLE metadata_items (
    id                      INTEGER       PRIMARY KEY AUTOINCREMENT
                                          NOT NULL,
    library_section_id      INTEGER,
    parent_id               INTEGER,
    metadata_type           INTEGER,
    guid                    VARCHAR (255),
    media_item_count        INTEGER,
    title                   VARCHAR (255),
    title_sort              VARCHAR (255) COLLATE NOCASE,
    original_title          VARCHAR (255),
    studio                  VARCHAR (255),
    rating                  FLOAT,
    rating_count            INTEGER,
    tagline                 VARCHAR (255),
    summary                 TEXT,
    trivia                  TEXT,
    quotes                  TEXT,
    content_rating          VARCHAR (255),
    content_rating_age      INTEGER,
    [index]                 INTEGER,
    absolute_index          INTEGER,
    duration                INTEGER,
    user_thumb_url          VARCHAR (255),
    user_art_url            VARCHAR (255),
    user_banner_url         VARCHAR (255),
    user_music_url          VARCHAR (255),
    user_fields             VARCHAR (255),
    tags_genre              VARCHAR (255),
    tags_collection         VARCHAR (255),
    tags_director           VARCHAR (255),
    tags_writer             VARCHAR (255),
    tags_star               VARCHAR (255),
    originally_available_at DATETIME,
    available_at            DATETIME,
    expires_at              DATETIME,
    refreshed_at            DATETIME,
    year                    INTEGER,
    added_at                DATETIME,
    created_at              DATETIME,
    updated_at              DATETIME,
    deleted_at              DATETIME,
    tags_country            VARCHAR (255),
    extra_data              VARCHAR (255),
    hash                    VARCHAR (255),
    audience_rating         FLOAT,
    changed_at              INTEGER (8)   DEFAULT 0,
    resources_changed_at    INTEGER (8)   DEFAULT 0,
    remote                  INTEGER
);


-- Table: metadata_relations
DROP TABLE IF EXISTS metadata_relations;

CREATE TABLE metadata_relations (
    id                       INTEGER  PRIMARY KEY AUTOINCREMENT
                                      NOT NULL,
    metadata_item_id         INTEGER,
    related_metadata_item_id INTEGER,
    relation_type            INTEGER,
    created_at               DATETIME,
    updated_at               DATETIME
);


-- Table: metadata_subscription_desired_items
DROP TABLE IF EXISTS metadata_subscription_desired_items;

CREATE TABLE metadata_subscription_desired_items (
    sub_id    INTEGER,
    remote_id VARCHAR (255) 
);


-- Table: play_queue_generators
DROP TABLE IF EXISTS play_queue_generators;

CREATE TABLE play_queue_generators (
    id               INTEGER       PRIMARY KEY AUTOINCREMENT
                                   NOT NULL,
    playlist_id      INTEGER,
    metadata_item_id INTEGER,
    uri              VARCHAR (255),
    [limit]          INTEGER,
    continuous       BOOLEAN,
    [order]          FLOAT,
    created_at       DATETIME      NOT NULL,
    updated_at       DATETIME      NOT NULL,
    changed_at       INTEGER (8)   DEFAULT 0,
    [recursive]      BOOLEAN,
    type             INTEGER,
    extra_data       VARCHAR (255) 
);


-- Table: play_queue_items
DROP TABLE IF EXISTS play_queue_items;

CREATE TABLE play_queue_items (
    id                      INTEGER PRIMARY KEY AUTOINCREMENT
                                    NOT NULL,
    play_queue_id           INTEGER,
    metadata_item_id        INTEGER,
    [order]                 FLOAT,
    up_next                 BOOLEAN,
    play_queue_generator_id INTEGER
);


-- Table: play_queues
DROP TABLE IF EXISTS play_queues;

CREATE TABLE play_queues (
    id                            INTEGER       PRIMARY KEY AUTOINCREMENT
                                                NOT NULL,
    client_identifier             VARCHAR (255),
    account_id                    INTEGER,
    playlist_id                   INTEGER,
    sync_item_id                  INTEGER,
    play_queue_generator_id       INTEGER,
    generator_start_index         INTEGER,
    generator_end_index           INTEGER,
    generator_items_count         INTEGER,
    generator_ids                 BLOB,
    seed                          INTEGER,
    current_play_queue_item_id    INTEGER,
    last_added_play_queue_item_id INTEGER,
    version                       INTEGER,
    created_at                    DATETIME,
    updated_at                    DATETIME,
    metadata_type                 INTEGER,
    total_items_count             INTEGER,
    generator_generator_ids       BLOB
);


-- Table: plugin_permissions
DROP TABLE IF EXISTS plugin_permissions;

CREATE TABLE plugin_permissions (
    id         INTEGER PRIMARY KEY AUTOINCREMENT
                       NOT NULL,
    plugin_id  INTEGER,
    account_id INTEGER,
    permission INTEGER
);


-- Table: plugin_prefixes
DROP TABLE IF EXISTS plugin_prefixes;

CREATE TABLE plugin_prefixes (
    id                 INTEGER       PRIMARY KEY AUTOINCREMENT
                                     NOT NULL,
    plugin_id          INTEGER,
    name               VARCHAR (255),
    prefix             VARCHAR (255),
    art_url            VARCHAR (255),
    thumb_url          VARCHAR (255),
    titlebar_url       VARCHAR (255),
    share              BOOLEAN,
    has_store_services BOOLEAN,
    prefs              BOOLEAN
);


-- Table: plugins
DROP TABLE IF EXISTS plugins;

CREATE TABLE plugins (
    id                INTEGER       PRIMARY KEY AUTOINCREMENT
                                    NOT NULL,
    identifier        VARCHAR (255),
    framework_version INTEGER,
    access_count      INTEGER,
    installed_at      DATETIME,
    accessed_at       DATETIME,
    modified_at       DATETIME
);


-- Table: preferences
DROP TABLE IF EXISTS preferences;

CREATE TABLE preferences (
    id    INTEGER       PRIMARY KEY AUTOINCREMENT
                        NOT NULL,
    name  VARCHAR (255),
    value VARCHAR (255) 
);


-- Table: schema_migrations
DROP TABLE IF EXISTS schema_migrations;

CREATE TABLE schema_migrations (
    version              VARCHAR (255) NOT NULL,
    rollback_sql         TEXT          DEFAULT NULL,
    optimize_on_rollback BOOLEAN       DEFAULT NULL
);


-- Table: section_locations
DROP TABLE IF EXISTS section_locations;

CREATE TABLE section_locations (
    id                 INTEGER       PRIMARY KEY AUTOINCREMENT
                                     NOT NULL,
    library_section_id INTEGER,
    root_path          VARCHAR (255),
    available          BOOLEAN       DEFAULT 't',
    scanned_at         DATETIME,
    created_at         DATETIME,
    updated_at         DATETIME
);


-- Table: spellfix_metadata_titles
DROP TABLE IF EXISTS spellfix_metadata_titles;

CREATE VIRTUAL TABLE spellfix_metadata_titles USING spellfix1;


-- Table: spellfix_metadata_titles_vocab
DROP TABLE IF EXISTS spellfix_metadata_titles_vocab;

CREATE TABLE spellfix_metadata_titles_vocab (
    id     INTEGER PRIMARY KEY,
    rank   INT,
    langid INT,
    word   TEXT,
    k1     TEXT,
    k2     TEXT
);


-- Table: spellfix_tag_titles
DROP TABLE IF EXISTS spellfix_tag_titles;

CREATE VIRTUAL TABLE spellfix_tag_titles USING spellfix1;


-- Table: spellfix_tag_titles_vocab
DROP TABLE IF EXISTS spellfix_tag_titles_vocab;

CREATE TABLE spellfix_tag_titles_vocab (
    id     INTEGER PRIMARY KEY,
    rank   INT,
    langid INT,
    word   TEXT,
    k1     TEXT,
    k2     TEXT
);


-- Table: statistics_bandwidth
DROP TABLE IF EXISTS statistics_bandwidth;

CREATE TABLE statistics_bandwidth (
    id         INTEGER     PRIMARY KEY AUTOINCREMENT
                           NOT NULL,
    account_id INTEGER,
    device_id  INTEGER,
    timespan   INTEGER,
    at         DATETIME,
    lan        BOOLEAN,
    bytes      INTEGER (8) 
);


-- Table: statistics_media
DROP TABLE IF EXISTS statistics_media;

CREATE TABLE statistics_media (
    id            INTEGER  PRIMARY KEY AUTOINCREMENT
                           NOT NULL,
    account_id    INTEGER,
    device_id     INTEGER,
    timespan      INTEGER,
    at            DATETIME,
    metadata_type INTEGER,
    count         INTEGER,
    duration      INTEGER
);


-- Table: statistics_resources
DROP TABLE IF EXISTS statistics_resources;

CREATE TABLE statistics_resources (
    id                         INTEGER  PRIMARY KEY AUTOINCREMENT
                                        NOT NULL,
    timespan                   INTEGER,
    at                         DATETIME,
    host_cpu_utilization       FLOAT,
    process_cpu_utilization    FLOAT,
    host_memory_utilization    FLOAT,
    process_memory_utilization FLOAT
);


-- Table: stream_types
DROP TABLE IF EXISTS stream_types;

CREATE TABLE stream_types (
    id   INTEGER       PRIMARY KEY AUTOINCREMENT
                       NOT NULL,
    name VARCHAR (255) 
);


-- Table: sync_schema_versions
DROP TABLE IF EXISTS sync_schema_versions;

CREATE TABLE sync_schema_versions (
    id         INTEGER     PRIMARY KEY AUTOINCREMENT
                           NOT NULL,
    version    INTEGER,
    changed_at INTEGER (8) 
);


-- Table: synced_ancestor_items
DROP TABLE IF EXISTS synced_ancestor_items;

CREATE TABLE synced_ancestor_items (
    id                INTEGER     PRIMARY KEY AUTOINCREMENT
                                  NOT NULL,
    sync_list_id      INTEGER (8),
    metadata_item_id  INTEGER,
    changed_at        INTEGER (8),
    reference_count   INTEGER,
    first_packaged_at INTEGER (8),
    parent_id         INTEGER,
    state             INTEGER
);


-- Table: synced_library_sections
DROP TABLE IF EXISTS synced_library_sections;

CREATE TABLE synced_library_sections (
    id                 INTEGER     PRIMARY KEY AUTOINCREMENT
                                   NOT NULL,
    sync_list_id       INTEGER (8),
    library_section_id INTEGER,
    changed_at         INTEGER (8),
    reference_count    INTEGER,
    first_packaged_at  INTEGER (8),
    state              INTEGER
);


-- Table: synced_metadata_items
DROP TABLE IF EXISTS synced_metadata_items;

CREATE TABLE synced_metadata_items (
    id                        INTEGER       PRIMARY KEY AUTOINCREMENT
                                            NOT NULL,
    sync_list_id              INTEGER (8),
    sync_item_id              INTEGER (8),
    metadata_item_id          INTEGER,
    changed_at                INTEGER (8),
    first_packaged_at         INTEGER (8),
    state                     INTEGER,
    state_context             INTEGER,
    selected_media_id         INTEGER,
    selected_part_id          INTEGER,
    media_decision            INTEGER,
    file_size                 INTEGER (8),
    media_analysis_extra_data VARCHAR (255),
    parent_id                 INTEGER,
    library_section_id        INTEGER
);


-- Table: synced_play_queue_generators
DROP TABLE IF EXISTS synced_play_queue_generators;

CREATE TABLE synced_play_queue_generators (
    id                      INTEGER     PRIMARY KEY AUTOINCREMENT
                                        NOT NULL,
    sync_list_id            INTEGER (8),
    sync_item_id            INTEGER (8),
    playlist_id             INTEGER,
    play_queue_generator_id INTEGER,
    changed_at              INTEGER (8),
    state                   INTEGER,
    state_context           INTEGER,
    first_packaged_at       INTEGER (8) 
);


-- Table: synchronization_files
DROP TABLE IF EXISTS synchronization_files;

CREATE TABLE synchronization_files (
    id                INTEGER       PRIMARY KEY AUTOINCREMENT
                                    NOT NULL,
    client_identifier VARCHAR (255),
    sync_list_id      INTEGER (8),
    sync_item_id      INTEGER (8),
    item_uri          VARCHAR (255),
    num_parts         INTEGER,
    state             INTEGER,
    state_context     INTEGER,
    extra_data        VARCHAR (255) 
);


-- Table: taggings
DROP TABLE IF EXISTS taggings;

CREATE TABLE taggings (
    id               INTEGER       PRIMARY KEY AUTOINCREMENT
                                   NOT NULL,
    metadata_item_id INTEGER,
    tag_id           INTEGER,
    [index]          INTEGER,
    text             VARCHAR (255),
    time_offset      INTEGER,
    end_time_offset  INTEGER,
    thumb_url        VARCHAR (255),
    created_at       DATETIME,
    extra_data       VARCHAR (255) 
);


-- Table: tags
DROP TABLE IF EXISTS tags;

CREATE TABLE tags (
    id               INTEGER       PRIMARY KEY AUTOINCREMENT
                                   NOT NULL,
    metadata_item_id INTEGER,
    tag              VARCHAR (255) COLLATE NOCASE,
    tag_type         INTEGER,
    user_thumb_url   VARCHAR (255),
    user_art_url     VARCHAR (255),
    user_music_url   VARCHAR (255),
    created_at       DATETIME,
    updated_at       DATETIME,
    tag_value        INTEGER,
    extra_data       VARCHAR (255),
    [key]            VARCHAR (255),
    parent_id        INTEGER
);


-- Table: versioned_metadata_items
DROP TABLE IF EXISTS versioned_metadata_items;

CREATE TABLE versioned_metadata_items (
    id                INTEGER     PRIMARY KEY AUTOINCREMENT
                                  NOT NULL,
    metadata_item_id  INTEGER,
    generator_id      INTEGER,
    target_tag_id     INTEGER,
    state             INTEGER,
    state_context     INTEGER,
    selected_media_id INTEGER,
    version_media_id  INTEGER,
    media_decision    INTEGER,
    file_size         INTEGER (8) 
);


-- Table: view_settings
DROP TABLE IF EXISTS view_settings;

CREATE TABLE view_settings (
    id          INTEGER       PRIMARY KEY AUTOINCREMENT
                              NOT NULL,
    account_id  INTEGER,
    client_type VARCHAR (255),
    view_group  VARCHAR (255),
    view_id     INTEGER,
    sort_id     INTEGER,
    sort_asc    BOOLEAN,
    created_at  DATETIME,
    updated_at  DATETIME
);


-- Index: index_accounts_on_name
DROP INDEX IF EXISTS index_accounts_on_name;

CREATE INDEX index_accounts_on_name ON accounts (
    "name"
);


-- Index: index_cloudsync_files_on_device_identifier_and_original_url
DROP INDEX IF EXISTS index_cloudsync_files_on_device_identifier_and_original_url;

CREATE INDEX index_cloudsync_files_on_device_identifier_and_original_url ON cloudsync_files (
    "device_identifier",
    "original_url"
);


-- Index: index_directories_on_deleted_at
DROP INDEX IF EXISTS index_directories_on_deleted_at;

CREATE INDEX index_directories_on_deleted_at ON directories (
    "deleted_at"
);


-- Index: index_directories_on_path
DROP INDEX IF EXISTS index_directories_on_path;

CREATE INDEX index_directories_on_path ON directories (
    "path"
);


-- Index: index_library_section_permissions_on_account_id
DROP INDEX IF EXISTS index_library_section_permissions_on_account_id;

CREATE INDEX index_library_section_permissions_on_account_id ON library_section_permissions (
    "account_id"
);


-- Index: index_library_section_permissions_on_library_section_id
DROP INDEX IF EXISTS index_library_section_permissions_on_library_section_id;

CREATE INDEX index_library_section_permissions_on_library_section_id ON library_section_permissions (
    "library_section_id"
);


-- Index: index_library_sections_on_changed_at
DROP INDEX IF EXISTS index_library_sections_on_changed_at;

CREATE INDEX index_library_sections_on_changed_at ON library_sections (
    "changed_at"
);


-- Index: index_library_sections_on_name
DROP INDEX IF EXISTS index_library_sections_on_name;

CREATE INDEX index_library_sections_on_name ON library_sections (
    "name"
);


-- Index: index_library_sections_on_name_sort
DROP INDEX IF EXISTS index_library_sections_on_name_sort;

CREATE INDEX index_library_sections_on_name_sort ON library_sections (
    "name_sort" COLLATE nocase
);


-- Index: index_library_timeline_entries_on_library_section_id
DROP INDEX IF EXISTS index_library_timeline_entries_on_library_section_id;

CREATE INDEX index_library_timeline_entries_on_library_section_id ON library_timeline_entries (
    "library_section_id"
);


-- Index: index_library_timeline_entries_on_metadata_item_id
DROP INDEX IF EXISTS index_library_timeline_entries_on_metadata_item_id;

CREATE INDEX index_library_timeline_entries_on_metadata_item_id ON library_timeline_entries (
    "metadata_item_id"
);


-- Index: index_library_timeline_entries_on_state
DROP INDEX IF EXISTS index_library_timeline_entries_on_state;

CREATE INDEX index_library_timeline_entries_on_state ON library_timeline_entries (
    "state"
);


-- Index: index_library_timeline_entries_on_updated_at
DROP INDEX IF EXISTS index_library_timeline_entries_on_updated_at;

CREATE INDEX index_library_timeline_entries_on_updated_at ON library_timeline_entries (
    "updated_at"
);


-- Index: index_media_item_settings_on_account_id
DROP INDEX IF EXISTS index_media_item_settings_on_account_id;

CREATE INDEX index_media_item_settings_on_account_id ON media_item_settings (
    "account_id"
);


-- Index: index_media_item_settings_on_media_item_id
DROP INDEX IF EXISTS index_media_item_settings_on_media_item_id;

CREATE INDEX index_media_item_settings_on_media_item_id ON media_item_settings (
    "media_item_id"
);


-- Index: index_media_items_on_deleted_at
DROP INDEX IF EXISTS index_media_items_on_deleted_at;

CREATE INDEX index_media_items_on_deleted_at ON media_items (
    "deleted_at"
);


-- Index: index_media_items_on_library_section_id
DROP INDEX IF EXISTS index_media_items_on_library_section_id;

CREATE INDEX index_media_items_on_library_section_id ON media_items (
    "library_section_id"
);


-- Index: index_media_items_on_media_analysis_version
DROP INDEX IF EXISTS index_media_items_on_media_analysis_version;

CREATE INDEX index_media_items_on_media_analysis_version ON media_items (
    "media_analysis_version"
);


-- Index: index_media_items_on_metadata_item_id
DROP INDEX IF EXISTS index_media_items_on_metadata_item_id;

CREATE INDEX index_media_items_on_metadata_item_id ON media_items (
    "metadata_item_id"
);


-- Index: index_media_part_settings_on_account_id
DROP INDEX IF EXISTS index_media_part_settings_on_account_id;

CREATE INDEX index_media_part_settings_on_account_id ON media_part_settings (
    "account_id"
);


-- Index: index_media_part_settings_on_changed_at
DROP INDEX IF EXISTS index_media_part_settings_on_changed_at;

CREATE INDEX index_media_part_settings_on_changed_at ON media_part_settings (
    "changed_at"
);


-- Index: index_media_part_settings_on_media_part_id
DROP INDEX IF EXISTS index_media_part_settings_on_media_part_id;

CREATE INDEX index_media_part_settings_on_media_part_id ON media_part_settings (
    "media_part_id"
);


-- Index: index_media_parts_on_deleted_at
DROP INDEX IF EXISTS index_media_parts_on_deleted_at;

CREATE INDEX index_media_parts_on_deleted_at ON media_parts (
    "deleted_at"
);


-- Index: index_media_parts_on_directory_id
DROP INDEX IF EXISTS index_media_parts_on_directory_id;

CREATE INDEX index_media_parts_on_directory_id ON media_parts (
    "directory_id"
);


-- Index: index_media_parts_on_file
DROP INDEX IF EXISTS index_media_parts_on_file;

CREATE INDEX index_media_parts_on_file ON media_parts (
    "file"
);


-- Index: index_media_parts_on_hash
DROP INDEX IF EXISTS index_media_parts_on_hash;

CREATE INDEX index_media_parts_on_hash ON media_parts (
    "hash"
);


-- Index: index_media_parts_on_media_item_id
DROP INDEX IF EXISTS index_media_parts_on_media_item_id;

CREATE INDEX index_media_parts_on_media_item_id ON media_parts (
    "media_item_id"
);


-- Index: index_media_parts_on_size
DROP INDEX IF EXISTS index_media_parts_on_size;

CREATE INDEX index_media_parts_on_size ON media_parts (
    "size"
);


-- Index: index_media_streams_on_language
DROP INDEX IF EXISTS index_media_streams_on_language;

CREATE INDEX index_media_streams_on_language ON media_streams (
    "language"
);


-- Index: index_media_streams_on_media_item_id
DROP INDEX IF EXISTS index_media_streams_on_media_item_id;

CREATE INDEX index_media_streams_on_media_item_id ON media_streams (
    "media_item_id"
);


-- Index: index_media_streams_on_media_part_id
DROP INDEX IF EXISTS index_media_streams_on_media_part_id;

CREATE INDEX index_media_streams_on_media_part_id ON media_streams (
    "media_part_id"
);


-- Index: index_metadata_item_accounts_on_account_id
DROP INDEX IF EXISTS index_metadata_item_accounts_on_account_id;

CREATE INDEX index_metadata_item_accounts_on_account_id ON metadata_item_accounts (
    "account_id"
);


-- Index: index_metadata_item_accounts_on_metadata_item_id
DROP INDEX IF EXISTS index_metadata_item_accounts_on_metadata_item_id;

CREATE INDEX index_metadata_item_accounts_on_metadata_item_id ON metadata_item_accounts (
    "metadata_item_id"
);


-- Index: index_metadata_item_settings_on_account_id
DROP INDEX IF EXISTS index_metadata_item_settings_on_account_id;

CREATE INDEX index_metadata_item_settings_on_account_id ON metadata_item_settings (
    "account_id"
);


-- Index: index_metadata_item_settings_on_changed_at
DROP INDEX IF EXISTS index_metadata_item_settings_on_changed_at;

CREATE INDEX index_metadata_item_settings_on_changed_at ON metadata_item_settings (
    "changed_at"
);


-- Index: index_metadata_item_settings_on_guid
DROP INDEX IF EXISTS index_metadata_item_settings_on_guid;

CREATE INDEX index_metadata_item_settings_on_guid ON metadata_item_settings (
    "guid"
);


-- Index: index_metadata_item_settings_on_last_viewed_at
DROP INDEX IF EXISTS index_metadata_item_settings_on_last_viewed_at;

CREATE INDEX index_metadata_item_settings_on_last_viewed_at ON metadata_item_settings (
    "last_viewed_at"
);


-- Index: index_metadata_item_settings_on_rating
DROP INDEX IF EXISTS index_metadata_item_settings_on_rating;

CREATE INDEX index_metadata_item_settings_on_rating ON metadata_item_settings (
    "rating"
);


-- Index: index_metadata_item_settings_on_skip_count
DROP INDEX IF EXISTS index_metadata_item_settings_on_skip_count;

CREATE INDEX index_metadata_item_settings_on_skip_count ON metadata_item_settings (
    "skip_count"
);


-- Index: index_metadata_item_settings_on_view_count
DROP INDEX IF EXISTS index_metadata_item_settings_on_view_count;

CREATE INDEX index_metadata_item_settings_on_view_count ON metadata_item_settings (
    "view_count"
);


-- Index: index_metadata_item_settings_on_view_offset
DROP INDEX IF EXISTS index_metadata_item_settings_on_view_offset;

CREATE INDEX index_metadata_item_settings_on_view_offset ON metadata_item_settings (
    "view_offset"
);


-- Index: index_metadata_item_views_on_guid
DROP INDEX IF EXISTS index_metadata_item_views_on_guid;

CREATE INDEX index_metadata_item_views_on_guid ON metadata_item_views (
    "guid"
);


-- Index: index_metadata_item_views_on_library_section_id
DROP INDEX IF EXISTS index_metadata_item_views_on_library_section_id;

CREATE INDEX index_metadata_item_views_on_library_section_id ON metadata_item_views (
    "library_section_id"
);


-- Index: index_metadata_item_views_on_viewed_at
DROP INDEX IF EXISTS index_metadata_item_views_on_viewed_at;

CREATE INDEX index_metadata_item_views_on_viewed_at ON metadata_item_views (
    "viewed_at"
);


-- Index: index_metadata_items_on_added_at
DROP INDEX IF EXISTS index_metadata_items_on_added_at;

CREATE INDEX index_metadata_items_on_added_at ON metadata_items (
    "added_at"
);


-- Index: index_metadata_items_on_changed_at
DROP INDEX IF EXISTS index_metadata_items_on_changed_at;

CREATE INDEX index_metadata_items_on_changed_at ON metadata_items (
    "changed_at"
);


-- Index: index_metadata_items_on_created_at
DROP INDEX IF EXISTS index_metadata_items_on_created_at;

CREATE INDEX index_metadata_items_on_created_at ON metadata_items (
    "created_at"
);


-- Index: index_metadata_items_on_deleted_at
DROP INDEX IF EXISTS index_metadata_items_on_deleted_at;

CREATE INDEX index_metadata_items_on_deleted_at ON metadata_items (
    "deleted_at"
);


-- Index: index_metadata_items_on_guid
DROP INDEX IF EXISTS index_metadata_items_on_guid;

CREATE INDEX index_metadata_items_on_guid ON metadata_items (
    "guid"
);


-- Index: index_metadata_items_on_hash
DROP INDEX IF EXISTS index_metadata_items_on_hash;

CREATE INDEX index_metadata_items_on_hash ON metadata_items (
    "hash"
);


-- Index: index_metadata_items_on_index
DROP INDEX IF EXISTS index_metadata_items_on_index;

CREATE INDEX index_metadata_items_on_index ON metadata_items (
    "index"
);


-- Index: index_metadata_items_on_library_section_id
DROP INDEX IF EXISTS index_metadata_items_on_library_section_id;

CREATE INDEX index_metadata_items_on_library_section_id ON metadata_items (
    "library_section_id"
);


-- Index: index_metadata_items_on_library_section_id_and_metadata_type_and_added_at
DROP INDEX IF EXISTS index_metadata_items_on_library_section_id_and_metadata_type_and_added_at;

CREATE INDEX index_metadata_items_on_library_section_id_and_metadata_type_and_added_at ON metadata_items (
    "library_section_id",
    "metadata_type",
    "added_at"
);


-- Index: index_metadata_items_on_metadata_type
DROP INDEX IF EXISTS index_metadata_items_on_metadata_type;

CREATE INDEX index_metadata_items_on_metadata_type ON metadata_items (
    "metadata_type"
);


-- Index: index_metadata_items_on_originally_available_at
DROP INDEX IF EXISTS index_metadata_items_on_originally_available_at;

CREATE INDEX index_metadata_items_on_originally_available_at ON metadata_items (
    "originally_available_at"
);


-- Index: index_metadata_items_on_parent_id
DROP INDEX IF EXISTS index_metadata_items_on_parent_id;

CREATE INDEX index_metadata_items_on_parent_id ON metadata_items (
    "parent_id"
);


-- Index: index_metadata_items_on_resources_changed_at
DROP INDEX IF EXISTS index_metadata_items_on_resources_changed_at;

CREATE INDEX index_metadata_items_on_resources_changed_at ON metadata_items (
    "resources_changed_at"
);


-- Index: index_metadata_items_on_title
DROP INDEX IF EXISTS index_metadata_items_on_title;

CREATE INDEX index_metadata_items_on_title ON metadata_items (
    "title"
);


-- Index: index_metadata_items_on_title_sort
DROP INDEX IF EXISTS index_metadata_items_on_title_sort;

CREATE INDEX index_metadata_items_on_title_sort ON metadata_items (
    "title_sort"
);


-- Index: index_metadata_relations_on_metadata_item_id
DROP INDEX IF EXISTS index_metadata_relations_on_metadata_item_id;

CREATE INDEX index_metadata_relations_on_metadata_item_id ON metadata_relations (
    "metadata_item_id"
);


-- Index: index_metadata_relations_on_related_metadata_item_id
DROP INDEX IF EXISTS index_metadata_relations_on_related_metadata_item_id;

CREATE INDEX index_metadata_relations_on_related_metadata_item_id ON metadata_relations (
    "related_metadata_item_id"
);


-- Index: index_metadata_relations_on_relation_type
DROP INDEX IF EXISTS index_metadata_relations_on_relation_type;

CREATE INDEX index_metadata_relations_on_relation_type ON metadata_relations (
    "relation_type"
);


-- Index: index_play_queue_generators_on_changed_at
DROP INDEX IF EXISTS index_play_queue_generators_on_changed_at;

CREATE INDEX index_play_queue_generators_on_changed_at ON play_queue_generators (
    "changed_at"
);


-- Index: index_play_queue_generators_on_metadata_item_id
DROP INDEX IF EXISTS index_play_queue_generators_on_metadata_item_id;

CREATE INDEX index_play_queue_generators_on_metadata_item_id ON play_queue_generators (
    "metadata_item_id"
);


-- Index: index_play_queue_generators_on_order
DROP INDEX IF EXISTS index_play_queue_generators_on_order;

CREATE INDEX index_play_queue_generators_on_order ON play_queue_generators (
    "order"
);


-- Index: index_play_queue_generators_on_playlist_id
DROP INDEX IF EXISTS index_play_queue_generators_on_playlist_id;

CREATE INDEX index_play_queue_generators_on_playlist_id ON play_queue_generators (
    "playlist_id"
);


-- Index: index_play_queue_items_on_metadata_item_id
DROP INDEX IF EXISTS index_play_queue_items_on_metadata_item_id;

CREATE INDEX index_play_queue_items_on_metadata_item_id ON play_queue_items (
    "metadata_item_id"
);


-- Index: index_play_queue_items_on_order
DROP INDEX IF EXISTS index_play_queue_items_on_order;

CREATE INDEX index_play_queue_items_on_order ON play_queue_items (
    "order"
);


-- Index: index_play_queue_items_on_play_queue_id
DROP INDEX IF EXISTS index_play_queue_items_on_play_queue_id;

CREATE INDEX index_play_queue_items_on_play_queue_id ON play_queue_items (
    "play_queue_id"
);


-- Index: index_play_queues_on_account_id
DROP INDEX IF EXISTS index_play_queues_on_account_id;

CREATE INDEX index_play_queues_on_account_id ON play_queues (
    "account_id"
);


-- Index: index_play_queues_on_client_identifier_and_account_id_and_metadata_type
DROP INDEX IF EXISTS index_play_queues_on_client_identifier_and_account_id_and_metadata_type;

CREATE UNIQUE INDEX index_play_queues_on_client_identifier_and_account_id_and_metadata_type ON play_queues (
    "client_identifier",
    "account_id",
    "metadata_type"
);


-- Index: index_play_queues_on_playlist_id
DROP INDEX IF EXISTS index_play_queues_on_playlist_id;

CREATE INDEX index_play_queues_on_playlist_id ON play_queues (
    "playlist_id"
);


-- Index: index_play_queues_on_sync_item_id
DROP INDEX IF EXISTS index_play_queues_on_sync_item_id;

CREATE INDEX index_play_queues_on_sync_item_id ON play_queues (
    "sync_item_id"
);


-- Index: index_plugin_permissions_on_account_id
DROP INDEX IF EXISTS index_plugin_permissions_on_account_id;

CREATE INDEX index_plugin_permissions_on_account_id ON plugin_permissions (
    "account_id"
);


-- Index: index_plugin_permissions_on_plugin_id
DROP INDEX IF EXISTS index_plugin_permissions_on_plugin_id;

CREATE INDEX index_plugin_permissions_on_plugin_id ON plugin_permissions (
    "plugin_id"
);


-- Index: index_plugin_prefixes_on_plugin_id
DROP INDEX IF EXISTS index_plugin_prefixes_on_plugin_id;

CREATE INDEX index_plugin_prefixes_on_plugin_id ON plugin_prefixes (
    "plugin_id"
);


-- Index: index_preferences_on_name
DROP INDEX IF EXISTS index_preferences_on_name;

CREATE UNIQUE INDEX index_preferences_on_name ON preferences (
    "name"
);


-- Index: index_sync_schema_versions_on_changed_at
DROP INDEX IF EXISTS index_sync_schema_versions_on_changed_at;

CREATE INDEX index_sync_schema_versions_on_changed_at ON sync_schema_versions (
    "changed_at"
);


-- Index: index_synced_ancestor_items_on_changed_at
DROP INDEX IF EXISTS index_synced_ancestor_items_on_changed_at;

CREATE INDEX index_synced_ancestor_items_on_changed_at ON synced_ancestor_items (
    "changed_at"
);


-- Index: index_synced_ancestor_items_on_metadata_item_id
DROP INDEX IF EXISTS index_synced_ancestor_items_on_metadata_item_id;

CREATE INDEX index_synced_ancestor_items_on_metadata_item_id ON synced_ancestor_items (
    "metadata_item_id"
);


-- Index: index_synced_ancestor_items_on_reference_count
DROP INDEX IF EXISTS index_synced_ancestor_items_on_reference_count;

CREATE INDEX index_synced_ancestor_items_on_reference_count ON synced_ancestor_items (
    "reference_count"
);


-- Index: index_synced_ancestor_items_on_sync_list_id
DROP INDEX IF EXISTS index_synced_ancestor_items_on_sync_list_id;

CREATE INDEX index_synced_ancestor_items_on_sync_list_id ON synced_ancestor_items (
    "sync_list_id"
);


-- Index: index_synced_ancestor_items_on_sync_list_id_and_metadata_item_id
DROP INDEX IF EXISTS index_synced_ancestor_items_on_sync_list_id_and_metadata_item_id;

CREATE UNIQUE INDEX index_synced_ancestor_items_on_sync_list_id_and_metadata_item_id ON synced_ancestor_items (
    "sync_list_id",
    "metadata_item_id"
);


-- Index: index_synced_library_sections_on_changed_at
DROP INDEX IF EXISTS index_synced_library_sections_on_changed_at;

CREATE INDEX index_synced_library_sections_on_changed_at ON synced_library_sections (
    "changed_at"
);


-- Index: index_synced_library_sections_on_library_section_id
DROP INDEX IF EXISTS index_synced_library_sections_on_library_section_id;

CREATE INDEX index_synced_library_sections_on_library_section_id ON synced_library_sections (
    "library_section_id"
);


-- Index: index_synced_library_sections_on_reference_count
DROP INDEX IF EXISTS index_synced_library_sections_on_reference_count;

CREATE INDEX index_synced_library_sections_on_reference_count ON synced_library_sections (
    "reference_count"
);


-- Index: index_synced_library_sections_on_sync_list_id
DROP INDEX IF EXISTS index_synced_library_sections_on_sync_list_id;

CREATE INDEX index_synced_library_sections_on_sync_list_id ON synced_library_sections (
    "sync_list_id"
);


-- Index: index_synced_library_sections_on_sync_list_id_and_library_section_id
DROP INDEX IF EXISTS index_synced_library_sections_on_sync_list_id_and_library_section_id;

CREATE UNIQUE INDEX index_synced_library_sections_on_sync_list_id_and_library_section_id ON synced_library_sections (
    "sync_list_id",
    "library_section_id"
);


-- Index: index_synced_metadata_items_on_changed_at
DROP INDEX IF EXISTS index_synced_metadata_items_on_changed_at;

CREATE INDEX index_synced_metadata_items_on_changed_at ON synced_metadata_items (
    "changed_at"
);


-- Index: index_synced_metadata_items_on_first_packaged_at
DROP INDEX IF EXISTS index_synced_metadata_items_on_first_packaged_at;

CREATE INDEX index_synced_metadata_items_on_first_packaged_at ON synced_metadata_items (
    "first_packaged_at"
);


-- Index: index_synced_metadata_items_on_metadata_item_id
DROP INDEX IF EXISTS index_synced_metadata_items_on_metadata_item_id;

CREATE INDEX index_synced_metadata_items_on_metadata_item_id ON synced_metadata_items (
    "metadata_item_id"
);


-- Index: index_synced_metadata_items_on_state
DROP INDEX IF EXISTS index_synced_metadata_items_on_state;

CREATE INDEX index_synced_metadata_items_on_state ON synced_metadata_items (
    "state"
);


-- Index: index_synced_metadata_items_on_sync_item_id
DROP INDEX IF EXISTS index_synced_metadata_items_on_sync_item_id;

CREATE INDEX index_synced_metadata_items_on_sync_item_id ON synced_metadata_items (
    "sync_item_id"
);


-- Index: index_synced_metadata_items_on_sync_list_id
DROP INDEX IF EXISTS index_synced_metadata_items_on_sync_list_id;

CREATE INDEX index_synced_metadata_items_on_sync_list_id ON synced_metadata_items (
    "sync_list_id"
);


-- Index: index_synced_metadata_items_on_sync_list_id_and_metadata_item_id
DROP INDEX IF EXISTS index_synced_metadata_items_on_sync_list_id_and_metadata_item_id;

CREATE UNIQUE INDEX index_synced_metadata_items_on_sync_list_id_and_metadata_item_id ON synced_metadata_items (
    "sync_list_id",
    "metadata_item_id"
);


-- Index: index_synced_play_queue_generators_on_changed_at
DROP INDEX IF EXISTS index_synced_play_queue_generators_on_changed_at;

CREATE INDEX index_synced_play_queue_generators_on_changed_at ON synced_play_queue_generators (
    "changed_at"
);


-- Index: index_synced_play_queue_generators_on_play_queue_generator_id
DROP INDEX IF EXISTS index_synced_play_queue_generators_on_play_queue_generator_id;

CREATE INDEX index_synced_play_queue_generators_on_play_queue_generator_id ON synced_play_queue_generators (
    "play_queue_generator_id"
);


-- Index: index_synced_play_queue_generators_on_playlist_id
DROP INDEX IF EXISTS index_synced_play_queue_generators_on_playlist_id;

CREATE INDEX index_synced_play_queue_generators_on_playlist_id ON synced_play_queue_generators (
    "playlist_id"
);


-- Index: index_synced_play_queue_generators_on_state
DROP INDEX IF EXISTS index_synced_play_queue_generators_on_state;

CREATE INDEX index_synced_play_queue_generators_on_state ON synced_play_queue_generators (
    "state"
);


-- Index: index_synced_play_queue_generators_on_sync_item_id
DROP INDEX IF EXISTS index_synced_play_queue_generators_on_sync_item_id;

CREATE INDEX index_synced_play_queue_generators_on_sync_item_id ON synced_play_queue_generators (
    "sync_item_id"
);


-- Index: index_synced_play_queue_generators_on_sync_list_id
DROP INDEX IF EXISTS index_synced_play_queue_generators_on_sync_list_id;

CREATE INDEX index_synced_play_queue_generators_on_sync_list_id ON synced_play_queue_generators (
    "sync_list_id"
);


-- Index: index_synced_play_queue_generators_on_sync_list_id_and_play_queue_generator_id
DROP INDEX IF EXISTS index_synced_play_queue_generators_on_sync_list_id_and_play_queue_generator_id;

CREATE UNIQUE INDEX index_synced_play_queue_generators_on_sync_list_id_and_play_queue_generator_id ON synced_play_queue_generators (
    "sync_list_id",
    "play_queue_generator_id"
);


-- Index: index_synchronization_files_on_client_identifier
DROP INDEX IF EXISTS index_synchronization_files_on_client_identifier;

CREATE INDEX index_synchronization_files_on_client_identifier ON synchronization_files (
    "client_identifier"
);


-- Index: index_synchronization_files_on_item_uri
DROP INDEX IF EXISTS index_synchronization_files_on_item_uri;

CREATE INDEX index_synchronization_files_on_item_uri ON synchronization_files (
    "item_uri"
);


-- Index: index_synchronization_files_on_sync_item_id
DROP INDEX IF EXISTS index_synchronization_files_on_sync_item_id;

CREATE INDEX index_synchronization_files_on_sync_item_id ON synchronization_files (
    "sync_item_id"
);


-- Index: index_synchronization_files_on_sync_list_id
DROP INDEX IF EXISTS index_synchronization_files_on_sync_list_id;

CREATE INDEX index_synchronization_files_on_sync_list_id ON synchronization_files (
    "sync_list_id"
);


-- Index: index_taggings_on_metadata_item_id
DROP INDEX IF EXISTS index_taggings_on_metadata_item_id;

CREATE INDEX index_taggings_on_metadata_item_id ON taggings (
    "metadata_item_id"
);


-- Index: index_taggings_on_tag_id
DROP INDEX IF EXISTS index_taggings_on_tag_id;

CREATE INDEX index_taggings_on_tag_id ON taggings (
    "tag_id"
);


-- Index: index_tags_on_tag
DROP INDEX IF EXISTS index_tags_on_tag;

CREATE INDEX index_tags_on_tag ON tags (
    "tag"
);


-- Index: index_tags_on_tag_type
DROP INDEX IF EXISTS index_tags_on_tag_type;

CREATE INDEX index_tags_on_tag_type ON tags (
    "tag_type"
);


-- Index: index_tags_on_tag_type_and_tag
DROP INDEX IF EXISTS index_tags_on_tag_type_and_tag;

CREATE INDEX index_tags_on_tag_type_and_tag ON tags (
    "tag_type",
    "tag"
);


-- Index: index_versioned_metadata_items_on_generator_id
DROP INDEX IF EXISTS index_versioned_metadata_items_on_generator_id;

CREATE INDEX index_versioned_metadata_items_on_generator_id ON versioned_metadata_items (
    "generator_id"
);


-- Index: index_versioned_metadata_items_on_metadata_item_id
DROP INDEX IF EXISTS index_versioned_metadata_items_on_metadata_item_id;

CREATE INDEX index_versioned_metadata_items_on_metadata_item_id ON versioned_metadata_items (
    "metadata_item_id"
);


-- Index: index_versioned_metadata_items_on_selected_media_id
DROP INDEX IF EXISTS index_versioned_metadata_items_on_selected_media_id;

CREATE INDEX index_versioned_metadata_items_on_selected_media_id ON versioned_metadata_items (
    "selected_media_id"
);


-- Index: index_versioned_metadata_items_on_target_tag_id
DROP INDEX IF EXISTS index_versioned_metadata_items_on_target_tag_id;

CREATE INDEX index_versioned_metadata_items_on_target_tag_id ON versioned_metadata_items (
    "target_tag_id"
);


-- Index: index_versioned_metadata_items_on_version_media_id
DROP INDEX IF EXISTS index_versioned_metadata_items_on_version_media_id;

CREATE INDEX index_versioned_metadata_items_on_version_media_id ON versioned_metadata_items (
    "version_media_id"
);


-- Index: index_view_settings_on_client_type
DROP INDEX IF EXISTS index_view_settings_on_client_type;

CREATE INDEX index_view_settings_on_client_type ON view_settings (
    "client_type"
);


-- Index: index_view_settings_on_view_group
DROP INDEX IF EXISTS index_view_settings_on_view_group;

CREATE INDEX index_view_settings_on_view_group ON view_settings (
    "view_group"
);


-- Index: spellfix_metadata_titles_vocab_index_langid_k2
DROP INDEX IF EXISTS spellfix_metadata_titles_vocab_index_langid_k2;

CREATE INDEX spellfix_metadata_titles_vocab_index_langid_k2 ON spellfix_metadata_titles_vocab (
    langid,
    k2
);


-- Index: spellfix_tag_titles_vocab_index_langid_k2
DROP INDEX IF EXISTS spellfix_tag_titles_vocab_index_langid_k2;

CREATE INDEX spellfix_tag_titles_vocab_index_langid_k2 ON spellfix_tag_titles_vocab (
    langid,
    k2
);


-- Index: unique_schema_migrations
DROP INDEX IF EXISTS unique_schema_migrations;

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations (
    "version"
);


-- Trigger: fts4_metadata_titles_after_insert
DROP TRIGGER IF EXISTS fts4_metadata_titles_after_insert;
CREATE TRIGGER fts4_metadata_titles_after_insert
         AFTER INSERT
            ON metadata_items
BEGIN
    INSERT INTO fts4_metadata_titles (
                                         docid,
                                         title,
                                         title_sort,
                                         original_title
                                     )
                                     VALUES (
                                         new.rowid,
                                         new.title,
                                         new.title_sort,
                                         new.original_title
                                     );
END;


-- Trigger: fts4_metadata_titles_after_update
DROP TRIGGER IF EXISTS fts4_metadata_titles_after_update;
CREATE TRIGGER fts4_metadata_titles_after_update
         AFTER UPDATE
            ON metadata_items
BEGIN
    INSERT INTO fts4_metadata_titles (
                                         docid,
                                         title,
                                         title_sort,
                                         original_title
                                     )
                                     VALUES (
                                         new.rowid,
                                         new.title,
                                         new.title_sort,
                                         new.original_title
                                     );
END;


-- Trigger: fts4_metadata_titles_before_delete
DROP TRIGGER IF EXISTS fts4_metadata_titles_before_delete;
CREATE TRIGGER fts4_metadata_titles_before_delete
        BEFORE DELETE
            ON metadata_items
BEGIN
    DELETE FROM fts4_metadata_titles
          WHERE docid = old.rowid;
END;


-- Trigger: fts4_metadata_titles_before_update
DROP TRIGGER IF EXISTS fts4_metadata_titles_before_update;
CREATE TRIGGER fts4_metadata_titles_before_update
        BEFORE UPDATE
            ON metadata_items
BEGIN
    DELETE FROM fts4_metadata_titles
          WHERE docid = old.rowid;
END;


-- Trigger: fts4_tag_titles_after_insert
DROP TRIGGER IF EXISTS fts4_tag_titles_after_insert;
CREATE TRIGGER fts4_tag_titles_after_insert
         AFTER INSERT
            ON tags
BEGIN
    INSERT INTO fts4_tag_titles (
                                    docid,
                                    tag
                                )
                                VALUES (
                                    new.rowid,
                                    new.tag
                                );
END;


-- Trigger: fts4_tag_titles_after_update
DROP TRIGGER IF EXISTS fts4_tag_titles_after_update;
CREATE TRIGGER fts4_tag_titles_after_update
         AFTER UPDATE
            ON tags
BEGIN
    INSERT INTO fts4_tag_titles (
                                    docid,
                                    tag
                                )
                                VALUES (
                                    new.rowid,
                                    new.tag
                                );
END;


-- Trigger: fts4_tag_titles_before_delete
DROP TRIGGER IF EXISTS fts4_tag_titles_before_delete;
CREATE TRIGGER fts4_tag_titles_before_delete
        BEFORE DELETE
            ON tags
BEGIN
    DELETE FROM fts4_tag_titles
          WHERE docid = old.rowid;
END;


-- Trigger: fts4_tag_titles_before_update
DROP TRIGGER IF EXISTS fts4_tag_titles_before_update;
CREATE TRIGGER fts4_tag_titles_before_update
        BEFORE UPDATE
            ON tags
BEGIN
    DELETE FROM fts4_tag_titles
          WHERE docid = old.rowid;
END;


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
