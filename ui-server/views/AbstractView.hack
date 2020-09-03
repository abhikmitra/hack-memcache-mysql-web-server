
abstract class AbstractView {
    abstract protected function getCSS(): Set<string>;
    abstract protected function getJS(): Set<string>;
    protected abstract function getTitleAsync(): Awaitable<string>;
    protected abstract function getBodyAsync(): Awaitable<\XHPRoot>;
    public async function render(): Awaitable<XHPRoot> {
        concurrent {
            $title = await $this->getTitleAsync();
            $content = await $this->getContentPaneAsync();
        }
        $extra_class = $this->getExtraBodyClass();
        $body_class = $this->getBodyClass($extra_class);
        $xhp =
            <x:doctype>
                <html>
                    <head>
                        <title>{$title}</title>
                        <meta charset="utf-8" />
                        <meta
                            name="viewport"
                            content="width=device-width, initial-scale=1.0"
                        />
                        <link rel="shortcut icon" href="/favicon.png" />
                        <link
                            href=
                                "https://fonts.googleapis.com/css?family=Open+Sans:400,400italic,700,700italic|Roboto:700"
                            rel="stylesheet"
                        />
                    </head>
                    <body class={$body_class}>
                        {$content}
                    </body>
                </html>
            </x:doctype>;
            return $xhp;
    }
    final protected async function getContentPaneAsync(): Awaitable<XHPRoot> {
        concurrent {
            $heading = await $this->getHeadingAsync();
            $body = await $this->getBodyAsync();
        }

        return (
            <div class="mainContainer">
                {$this->getTitleContent($heading)}
                <div class="widthWrapper flexWrapper">
                    <div class="mainWrapper">
                        {$body}
                    </div>
                </div>
            </div>
        );
    }
    protected function getHeadingAsync(): Awaitable<string> {
        return $this->getTitleAsync();
    }

    protected function getExtraBodyClass(): ?string {
        return null;
    }

    private function getBodyClass(?string $extra_class): string {
        return "body";
    }

    private function getTitleContent(string $title): XHPRoot {
        $title_class = "mainTitle mainTitle";
        return
            <div class={$title_class}>
                <div class="widthWrapper">
                    <h1 class="pageTitle">{$title}</h1>
                </div>
            </div>;
    }
    public function __construct() {
    }
}
